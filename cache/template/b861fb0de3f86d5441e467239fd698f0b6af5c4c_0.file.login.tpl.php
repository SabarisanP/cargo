<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 10:08:42
  from 'E:\xampp\htdocs\cargo\application\views\site\user\login.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66540e5226b322_59203143',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b861fb0de3f86d5441e467239fd698f0b6af5c4c' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\user\\login.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/user/header.tpl' => 1,
    'file:site/user/footer.tpl' => 1,
  ),
),false)) {
function content_66540e5226b322_59203143 (Smarty_Internal_Template $_smarty_tpl) {
?>		<?php $_smarty_tpl->_subTemplateRender('file:site/user/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

		<!-- Login-Section -->
		<section class="login-section section-gap-full">
			<div class="container">
				<div class="row">
					<div class="col-md-6 col-lg-5 login-left">
						<div id="signin-panel">
							<h1>Sign In</h1>
							<h5>Few seconds lets validate your profile</h5><br>
							<form>
								<div class="row">
									<div class="col-md-12 form-group">
										<label class="login-label">Enter your Client ID<sup>*</sup></label>
										<input type="text" class="login-control form-control" id="opcode" placeholder="Enter ID" required="" value="<?php echo $_smarty_tpl->tpl_vars['ns']->value;?>
">
									</div>
									<div class="col-md-12 form-group">
										<button type="button" id="btn-signin" class="btn btn-lg btn-clr rounded-pill btn-block waves" onclick="verifyOperatorCode()">Next <i class="fa fa-arrow-right"></i></button>
									</div>
								</div>
								<div id="verify-state" class="text-center"></div>
							</form>
							<div class="bottom-content text-center">
								<div class="bottom-title">
									<h6>Not able to Login</h6>
								</div>
								<p>Contact your Account Manager <br>or<br>Call us to: <a href="tel:+919500007529">+91 95000 07529</a></p>
							</div>
						</div>

												<div id="login-panel" class="login-form d-none">
							<h3>Welcome <span id="op_name"></span></h3>
							<h5>Enter your username & password to access</h5><br>
							<form>
								<div class="row">
									<div class="col-md-12 form-group d-none">
										<label class="login-label">Operator Code<sup>*</sup></label>
										<input type="text" class="login-control form-control" id="l_domain" placeholder="Operator Code" required="" value="<?php echo $_smarty_tpl->tpl_vars['ns']->value;?>
">
									</div>
									<div class="col-md-12 form-group">
										<label class="login-label">Username<sup>*</sup></label>
										<input type="text" class="login-control form-control" id="l_email" placeholder="Username" required="" value="<?php echo $_smarty_tpl->tpl_vars['email']->value;?>
">
									</div>
									<div class="col-md-12 form-group">
										<label class="login-label">Password<sup>*</sup></label>
										<input type="password" class="login-control form-control" id="l_password" placeholder="Password" value="">
									</div>
									<div class="col-md-12 form-group">
										<div class="checkbox">
											<label><input type="checkbox" value="remember-me" id="l_remember" <?php if ($_smarty_tpl->tpl_vars['remember']->value !== 0) {?>checked<?php }?>> Remember me </label>
										</div>
									</div>
									<div class="col-md-4 form-group">
										<button type="button" id="btn-back" class="btn btn-clr-2 btn-block btn-success text-uppercase" onclick="signInBack();"><i class="fa fa-arrow-left"></i> Back</button>
									</div>
									<div class="col-md-8 form-group">
										<button type="button" id="btn-login" class="btn btn-clr btn-block btn-success text-uppercase waves">Login</button>
									</div>
								</div>
								<div class="form-group" id="login-state"></div>
							</form>
							<div class="bottom-content text-center">
								<div class="bottom-title">
									<h6>Not able to Login</h6>
								</div>
								<p>Contact your Account Manager <br>or<br>Call us to: <a href="tel:+919500007529">+91 95000 07529</a></p>
							</div>
						</div>
					</div>

					<div class="col-lg-1"></div>

					<div class="col-md-6 col-lg-6">
						<div class="login-right">
							<div class="row owl-carousel" id="login-slider">
								<div class="slider-inner">
									<h2 class="font-weight-bold"><span class="text-clr-1">Cargo Management</span> Software Solutions</h2><br>
									<img src="assets/img/login/cargo-truck.png" alt="Truck" class="img-fluid">
								</div>
								<div class="slider-inner">
									<div class="adv-login-section">
										<div class="row">
											<div class="col-lg-8">
												<h5 class="text-clr-3 font-weight-bold"> Advanced <span class="text-clr-2"> Login Solutions</span></h5>
											</div>
											<div class="col-lg text-right">
												<img src="assets/img/login/login-solution.png" alt="Advanced-Login" class="img-fluid">
											</div>
										</div>
										<div class="transit-card">
											<h5>Access your portal in a <span class="text-clr-1">More Secure Way</span> </h5>
											<p>Delivering secure identity management without sacrificing end-user experience.</p>
											<h4>
												<span class="badge border">2 Factor Auth.</span>
												<span class="badge border">User &amp; Pwd Login</span>
												<span class="badge border">OTP based Login</span>
												<span class="badge border">.ExE Machine Login</span>
											</h4>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<?php $_smarty_tpl->_subTemplateRender('file:site/user/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
}
}
