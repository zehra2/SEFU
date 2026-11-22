import os
import zipfile

def make_update_pack():
    zip_name = "SEFU_v5_Kenya_DHA_Update_Pack.zip"
    
    include_subdirs = [
        "application/config",
        "application/controllers",
        "application/models",
        "application/views",
        "application/core",
        "application/libraries",
        "documentation",
        "scripts"
    ]
    
    include_files = [
        "SEFU_Production_Database_Latest.sql",
        "SEFU_HMIS_Completed_Features_and_Navigation_Guide.xlsx",
        "DHA_HMIS_Developer_Compliance_Tracker.md",
        "DHA_HMIS_Developer_Compliance_Tracker.csv",
        "SYSTEM_IMPLEMENTATION_HISTORY.md",
        "SEFU_HMIS_User_and_Administrator_Manual.md",
        "SEFU_HMIS_Functional_and_System_Requirements_Specification_FRS_SRS.md",
        "SEFU_HMIS_Database_Data_Dictionary_and_Architecture.md"
    ]
    
    print(f"Building fast update pack: {zip_name}...")
    with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zf:
        # Add targeted directories
        for target_dir in include_subdirs:
            if not os.path.exists(target_dir):
                continue
            for root, dirs, files in os.walk(target_dir):
                for f in files:
                    if f.endswith('.tmp') or f.endswith('.log'):
                        continue
                    fp = os.path.join(root, f)
                    arc = fp.replace("\\", "/")
                    zf.write(fp, arc)
        
        # Add root files
        for rf in include_files:
            if os.path.exists(rf):
                zf.write(rf, rf)

    size_mb = os.path.getsize(zip_name) / (1024 * 1024)
    print(f"Fast Update Pack created successfully: {zip_name} ({size_mb:.2f} MB)")

if __name__ == "__main__":
    make_update_pack()
