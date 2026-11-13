<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-color" content="#424242" />
        <?php
        $titleresult = $this->customlib->getTitleName();
        $logoresult  = $this->customlib->getLogoImage();
        $title_name  = !empty($titleresult["name"]) ? $titleresult["name"] : "SEFU Hospital";
        ?>
        <title><?php echo $title_name; ?> — Two-Factor Authentication</title>
        <link href="<?php echo base_url() . "uploads/hospital_content/logo/" . $logoresult["mini_logo"] ?>" rel="shortcut icon" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="<?php echo base_url(); ?>backend/usertemplate/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="<?php echo base_url(); ?>backend/usertemplate/assets/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="<?php echo base_url(); ?>backend/usertemplate/assets/css/form-elements.css">
        <link rel="stylesheet" href="<?php echo base_url(); ?>backend/usertemplate/assets/css/style.css">
        <style type="text/css">
            .col-md-offset-3 { margin-left: 29%; }
            .loginbg {
                background: #39f;
                box-shadow: 0 10px 18px 0 rgba(62, 57, 107, 0.2);
                border-radius: 4px;
            }
            .otp-input {
                font-size: 26px !important;
                letter-spacing: 12px;
                text-align: center;
                height: 54px !important;
                font-weight: bold;
                color: #204562;
                background: #ffffff !important;
                border: 2px solid #ff9800 !important;
                border-radius: 6px;
            }
            .otp-input:focus {
                border-color: #fbc02d !important;
                box-shadow: 0 0 10px rgba(255, 152, 0, 0.5) !important;
            }
            button.btn {
                margin: 0;
                padding: 0 20px;
                vertical-align: middle;
                background: #ff9800;
                border: 0;
                font-family: 'Roboto', sans-serif;
                font-size: 16px;
                font-weight: 500;
                color: #fff;
                border-radius: 4px;
                height: 48px;
                transition: all .3s;
            }
            button.btn:hover { background: #fbc02d; color: #fff; }
            .mfa-info-box {
                background: rgba(255, 255, 255, 0.15);
                padding: 12px;
                border-radius: 4px;
                margin-bottom: 20px;
                color: #ffffff;
                font-size: 13px;
                line-height: 1.5;
            }
            .resend-link {
                color: #b0de37;
                font-size: 13px;
                text-decoration: none;
            }
            .resend-link:hover {
                color: #ffffff;
                text-decoration: underline;
            }
            .dev-badge {
                background: #fff3cd;
                color: #856404;
                border: 1px dashed #ffeeba;
                padding: 8px 12px;
                border-radius: 4px;
                font-size: 12px;
                margin-top: 15px;
                text-align: center;
            }
            @media (max-width: 767px){ .col-md-offset-3 { margin-left: 0; } }
        </style>
    </head>
    <body>
        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5 col-sm-5 form-box col-md-offset-3">
                            <div class="loginbg">
                                <div class="form-top">
                                    <?php
                                    $logo_image = !empty($logoresult["image"]) 
                                        ? base_url() . "uploads/hospital_content/logo/" . $logoresult["image"] 
                                        : base_url() . "uploads/hospital_content/logo/s_logo.png";
                                    ?>
                                    <div class="form-top-left">
                                        <img src="<?php echo $logo_image . img_time(); ?>">
                                    </div>
                                    <div class="form-top-right">
                                        <i class="fa fa-shield" style="color: #ff9800;"></i>
                                    </div>
                                </div>
                                <div class="form-bottom">
                                    <h3 class="font-white bolds" style="margin-top: 0;">Two-Factor Authentication</h3>
                                    
                                    <div class="mfa-info-box">
                                        <i class="fa fa-envelope-o"></i> A 6-digit verification code has been sent to your registered email: <strong><?php echo htmlspecialchars($masked_email); ?></strong>
                                    </div>

                                    <?php if (!empty($error_message)): ?>
                                        <div class="alert alert-danger" style="font-size: 13px;">
                                            <i class="fa fa-exclamation-triangle"></i> <?php echo $error_message; ?>
                                        </div>
                                    <?php endif; ?>

                                    <?php if (!empty($success_message)): ?>
                                        <div class="alert alert-success" style="font-size: 13px;">
                                            <i class="fa fa-check-circle"></i> <?php echo $success_message; ?>
                                        </div>
                                    <?php endif; ?>

                                    <form action="<?php echo site_url('site/verify_2fa'); ?>" method="post">
                                        <?php echo $this->customlib->getCSRF(); ?>
                                        
                                        <div class="form-group">
                                            <label class="sr-only" for="otp_code">Verification Code</label>
                                            <input type="text" name="otp_code" id="otp_code" 
                                                   placeholder="• • • • • •" 
                                                   maxlength="6" 
                                                   pattern="[0-9]*" 
                                                   inputmode="numeric" 
                                                   autocomplete="one-time-code" 
                                                   autofocus 
                                                   class="form-control otp-input">
                                        </div>

                                        <button type="submit" class="btn btn-block">
                                            <i class="fa fa-check"></i> Verify & Sign In
                                        </button>
                                    </form>

                                    <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.2); padding-top: 15px;">
                                        <a href="<?php echo site_url('site/resend_2fa'); ?>" class="resend-link">
                                            <i class="fa fa-refresh"></i> Resend Code
                                        </a>
                                        <a href="<?php echo site_url('site/cancel_2fa'); ?>" style="color: #ffffff; font-size: 13px;">
                                            <i class="fa fa-arrow-left"></i> Back to Login
                                        </a>
                                    </div>

                                    <?php if (!empty($dev_otp_hint)): ?>
                                        <div class="dev-badge">
                                            <i class="fa fa-terminal"></i> <strong>Dev / Sandbox OTP:</strong> 
                                            <code style="font-size: 14px; font-weight: bold; color: #d9534f;"><?php echo $dev_otp_hint; ?></code>
                                            <br><small>(Displayed automatically on localhost for testing verification)</small>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="<?php echo base_url(); ?>backend/usertemplate/assets/js/jquery-1.11.1.min.js"></script>
        <script src="<?php echo base_url(); ?>backend/usertemplate/assets/bootstrap/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function() {
                // Auto focus and filter non-digits
                $('#otp_code').on('input', function() {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    if (this.value.length === 6) {
                        // Optional auto-submit when 6 digits are typed
                    }
                });
            });
        </script>
    </body>
</html>

