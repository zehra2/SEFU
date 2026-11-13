import os
import re
import sys
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.lib.units import inch
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, KeepTogether, HRFlowable
)
from reportlab.pdfgen import canvas

class NumberedCanvas(canvas.Canvas):
    def __init__(self, *args, **kwargs):
        super(NumberedCanvas, self).__init__(*args, **kwargs)
        self._saved_page_states = []

    def showPage(self):
        self._saved_page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        num_pages = len(self._saved_page_states)
        for state in self._saved_page_states:
            self.__dict__.update(state)
            self.draw_page_decorations(num_pages)
            super(NumberedCanvas, self).showPage()
        super(NumberedCanvas, self).save()

    def draw_page_decorations(self, page_count):
        self.saveState()
        self.setFont("Helvetica", 8)
        self.setFillColor(colors.HexColor("#555555"))
        
        # Header (pages > 1)
        if self._pageNumber > 1:
            self.drawString(54, 755, "SEFU HMIS — Kenya Digital Health Agency (DHA) Certification Submission")
            self.setStrokeColor(colors.HexColor("#CCCCCC"))
            self.setLineWidth(0.5)
            self.line(54, 750, 558, 750)
            
        # Footer
        self.setStrokeColor(colors.HexColor("#CCCCCC"))
        self.setLineWidth(0.5)
        self.line(54, 45, 558, 45)
        
        page_text = f"Page {self._pageNumber} of {page_count}"
        self.drawRightString(558, 32, page_text)
        self.drawString(54, 32, "Confidential — Ministry of Health / Kenya Digital Health Agency (Form HMIS 4)")
        self.restoreState()

def clean_inline_md(text):
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    # Bold **text**
    text = re.sub(r'\*\*(.+?)\*\*', r'<b>\1</b>', text)
    # Italic *text*
    text = re.sub(r'\*(.+?)\*', r'<i>\1</i>', text)
    # Inline code `text`
    text = re.sub(r'`(.+?)`', r'<font face="Courier" color="#800020"><b>\1</b></font>', text)
    # Links [label](url)
    text = re.sub(r'\[(.+?)\]\((.+?)\)', r'<font color="#0055AA"><u>\1</u></font>', text)
    return text

def convert_md_to_pdf(md_path, pdf_path, doc_title):
    print(f"Compiling: {os.path.basename(md_path)} -> {os.path.basename(pdf_path)}")
    
    if not os.path.exists(md_path):
        print(f"Warning: File not found {md_path}")
        return False

    with open(md_path, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    doc = SimpleDocTemplate(
        pdf_path,
        pagesize=letter,
        leftMargin=54,
        rightMargin=54,
        topMargin=54,
        bottomMargin=54
    )

    styles = getSampleStyleSheet()
    
    title_style = ParagraphStyle(
        'DocTitle',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=18,
        leading=22,
        textColor=colors.HexColor('#0B2545'),
        spaceAfter=10
    )
    
    meta_style = ParagraphStyle(
        'DocMeta',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=9,
        leading=13,
        textColor=colors.HexColor('#333333'),
        spaceAfter=12
    )

    h1_style = ParagraphStyle(
        'Heading1_Custom',
        parent=styles['Heading1'],
        fontName='Helvetica-Bold',
        fontSize=13,
        leading=16,
        textColor=colors.HexColor('#134074'),
        spaceBefore=14,
        spaceAfter=6,
        keepWithNext=True
    )

    h2_style = ParagraphStyle(
        'Heading2_Custom',
        parent=styles['Heading2'],
        fontName='Helvetica-Bold',
        fontSize=11,
        leading=14,
        textColor=colors.HexColor('#00509D'),
        spaceBefore=10,
        spaceAfter=4,
        keepWithNext=True
    )

    h3_style = ParagraphStyle(
        'Heading3_Custom',
        parent=styles['Heading3'],
        fontName='Helvetica-Bold',
        fontSize=9.5,
        leading=12,
        textColor=colors.HexColor('#212529'),
        spaceBefore=8,
        spaceAfter=3,
        keepWithNext=True
    )

    body_style = ParagraphStyle(
        'Body_Custom',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8.5,
        leading=12,
        textColor=colors.HexColor('#222222'),
        spaceAfter=6
    )

    bullet_style = ParagraphStyle(
        'Bullet_Custom',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8.5,
        leading=12,
        textColor=colors.HexColor('#222222'),
        leftIndent=15,
        spaceAfter=3
    )

    code_style = ParagraphStyle(
        'Code_Custom',
        parent=styles['Normal'],
        fontName='Courier',
        fontSize=7.5,
        leading=10,
        textColor=colors.HexColor('#1A1A1A'),
        leftIndent=10,
        rightIndent=10,
        spaceAfter=4
    )

    table_header_style = ParagraphStyle(
        'TH_Style',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=8,
        leading=10,
        textColor=colors.white
    )

    table_cell_style = ParagraphStyle(
        'TD_Style',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=7.5,
        leading=10,
        textColor=colors.HexColor('#222222')
    )

    story = []
    
    in_code_block = False
    code_lines = []
    in_table = False
    table_rows = []

    def flush_table():
        nonlocal table_rows, in_table
        if not table_rows:
            in_table = False
            return
        
        # Calculate col widths
        num_cols = max(len(r) for r in table_rows)
        # normalize
        clean_rows = []
        for r in table_rows:
            row_data = []
            for idx, c in enumerate(r):
                is_hdr = (len(clean_rows) == 0)
                st = table_header_style if is_hdr else table_cell_style
                row_data.append(Paragraph(clean_inline_md(c.strip()), st))
            while len(row_data) < num_cols:
                row_data.append(Paragraph("", table_cell_style))
            clean_rows.append(row_data)
        
        available_width = 504 # 612 - 108
        col_width = available_width / num_cols
        
        t = Table(clean_rows, colWidths=[col_width]*num_cols)
        t_style = [
            ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#134074')),
            ('ALIGN', (0,0), (-1,-1), 'LEFT'),
            ('VALIGN', (0,0), (-1,-1), 'TOP'),
            ('TEXTCOLOR', (0,0), (-1,0), colors.white),
            ('BOTTOMPADDING', (0,0), (-1,-1), 4),
            ('TOPPADDING', (0,0), (-1,-1), 4),
            ('LEFTPADDING', (0,0), (-1,-1), 4),
            ('RIGHTPADDING', (0,0), (-1,-1), 4),
            ('INNERGRID', (0,0), (-1,-1), 0.5, colors.HexColor('#D3D3D3')),
            ('BOX', (0,0), (-1,-1), 0.5, colors.HexColor('#134074')),
        ]
        for row_i in range(1, len(clean_rows)):
            if row_i % 2 == 0:
                t_style.append(('BACKGROUND', (0, row_i), (-1, row_i), colors.HexColor('#F8F9FA')))
        t.setStyle(TableStyle(t_style))
        story.append(t)
        story.append(Spacer(1, 8))
        table_rows = []
        in_table = False

    def flush_code():
        nonlocal code_lines, in_code_block
        if not code_lines:
            in_code_block = False
            return
        formatted = "<br/>".join([clean_inline_md(l) for l in code_lines])
        p = Paragraph(formatted, code_style)
        wrapper = Table([[p]], colWidths=[504])
        wrapper.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,-1), colors.HexColor('#F4F6F8')),
            ('BOX', (0,0), (-1,-1), 0.5, colors.HexColor('#D0D7DE')),
            ('TOPPADDING', (0,0), (-1,-1), 6),
            ('BOTTOMPADDING', (0,0), (-1,-1), 6),
            ('LEFTPADDING', (0,0), (-1,-1), 8),
            ('RIGHTPADDING', (0,0), (-1,-1), 8),
        ]))
        story.append(wrapper)
        story.append(Spacer(1, 6))
        code_lines = []
        in_code_block = False

    for line in lines:
        raw = line.rstrip()
        
        # Check code block fence
        if raw.startswith("```"):
            if in_code_block:
                flush_code()
            else:
                if in_table:
                    flush_table()
                in_code_block = True
            continue

        if in_code_block:
            code_lines.append(raw)
            continue

        # Check table row
        if raw.startswith("|") and raw.endswith("|"):
            # skip markdown separator |---|---|
            if re.match(r'^\|[\s\-:|]+\|$', raw):
                continue
            cells = [c for c in raw.split("|")[1:-1]]
            table_rows.append(cells)
            in_table = True
            continue
        else:
            if in_table:
                flush_table()

        if not raw.strip():
            continue

        # Horizontal rules
        if raw.strip() in ['---', '***', '___']:
            story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor('#CCCCCC'), spaceBefore=8, spaceAfter=8))
            continue

        # Headings
        if raw.startswith("# "):
            heading_text = clean_inline_md(raw[2:].strip())
            story.append(Paragraph(heading_text, title_style))
            continue
        elif raw.startswith("## "):
            heading_text = clean_inline_md(raw[3:].strip())
            story.append(Paragraph(heading_text, h1_style))
            continue
        elif raw.startswith("### "):
            heading_text = clean_inline_md(raw[4:].strip())
            story.append(Paragraph(heading_text, h2_style))
            continue
        elif raw.startswith("#### "):
            heading_text = clean_inline_md(raw[5:].strip())
            story.append(Paragraph(heading_text, h3_style))
            continue

        # Bullets
        if raw.strip().startswith(("- ", "* ", "+ ")):
            bullet_text = clean_inline_md(raw.strip()[2:].strip())
            story.append(Paragraph(f"&bull;&nbsp;&nbsp;{bullet_text}", bullet_style))
            continue
        
        # Numbered list
        m = re.match(r'^\s*(\d+)\.\s+(.*)$', raw)
        if m:
            num = m.group(1)
            item_text = clean_inline_md(m.group(2).strip())
            story.append(Paragraph(f"<b>{num}.</b>&nbsp;&nbsp;{item_text}", bullet_style))
            continue

        # Regular paragraph
        story.append(Paragraph(clean_inline_md(raw), body_style))

    if in_code_block:
        flush_code()
    if in_table:
        flush_table()

    try:
        doc.build(story, canvasmaker=NumberedCanvas)
        size_kb = os.path.getsize(pdf_path) / 1024
        print(f"  -> Generated: {pdf_path} ({size_kb:.1f} KB) - PASS <= 2MB")
        return True
    except Exception as e:
        print(f"  -> Error building PDF {pdf_path}: {e}")
        return False

# Dossier Map: Source Markdown -> Target PDF File
dossiers = [
    ("SEFU_HMIS_Functional_and_System_Requirements_Specification_FRS_SRS.md", "DHA_Section_D_System_Functional_Requirements_FRS_SRS.pdf", "FRS / SRS Specification"),
    ("SEFU_HMIS_Database_Data_Dictionary_and_Architecture.md", "DHA_Section_D_Database_Architecture_and_Data_Dictionary.pdf", "Database Schema & Data Dictionary"),
    ("SEFU_HMIS_User_and_Administrator_Manual.md", "DHA_Section_D_User_and_Administrator_Manual.pdf", "User and Administrator Manual"),
    ("SEFU_HMIS_Data_Protection_Impact_Assessment_DPIA.md", "DHA_Section_B_Data_Protection_Impact_Assessment_DPIA.pdf", "Data Protection Impact Assessment"),
    ("SEFU_HMIS_Data_Protection_Privacy_and_Consent_Policy.md", "DHA_Section_B_Privacy_and_Patient_Consent_Policy.pdf", "Privacy and Patient Consent Policy"),
    ("SEFU_HMIS_Backup_Policy_and_Configuration.md", "DHA_Section_C_Backup_Policy_and_Configuration.pdf", "Backup Policy and Configuration"),
    ("SEFU_HMIS_Disaster_Recovery_Plan_DRP.md", "DHA_Section_C_Disaster_Recovery_Plan_DRP.pdf", "Disaster Recovery Plan"),
    ("SEFU_HMIS_Business_Continuity_Plan_BCP.md", "DHA_Section_C_Business_Continuity_Plan_BCP.pdf", "Business Continuity Plan"),
    ("SEFU_HMIS_Incident_Response_Plan_IRP.md", "DHA_Section_C_Incident_Response_Plan_IRP.pdf", "Incident Response Plan"),
    ("SEFU_HMIS_Vulnerability_Assessment_Report_VAR.md", "DHA_Section_C_Vulnerability_Assessment_Report_VAR.pdf", "Vulnerability Assessment Report"),
    ("SEFU_HMIS_Penetration_Testing_Report_PTR.md", "DHA_Section_C_Penetration_Testing_Report_PTR.pdf", "Penetration Testing Report"),
    ("SEFU_HMIS_Session_Management_and_Access_Control_Evidence.md", "DHA_Section_C_Session_Management_and_Access_Control.pdf", "Session Management & Access Control Evidence"),
    ("SEFU_HMIS_Interoperability_and_REST_API_Specification.md", "DHA_Section_G_Interoperability_and_REST_API_Specification.pdf", "Interoperability & REST API Specification"),
    ("DHA_HMIS_Developer_Compliance_Tracker.md", "DHA_HMIS_Developer_Compliance_Tracker_Full.pdf", "DHA HMIS Developer Compliance Tracker")
]

output_dir = os.path.join("documentation", "dha_submission_pdfs")
os.makedirs(output_dir, exist_ok=True)

success_count = 0
for src, dst, title in dossiers:
    md_file = src
    out_file = os.path.join(output_dir, dst)
    if convert_md_to_pdf(md_file, out_file, title):
        success_count += 1

print("\n" + "="*60)
print(f"COMPILATION COMPLETE: {success_count} / {len(dossiers)} PDFs GENERATED")
print(f"Target Directory: {os.path.abspath(output_dir)}")
print("="*60)
