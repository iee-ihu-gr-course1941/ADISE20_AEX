<!DOCTYPE html>
<html>
<head>
	<title>LOGIN</title>
	<link rel="stylesheet" type="text/css" href="../../../../../xampp/htdocs/ADISE/style.css">
</head>
<body>

    <img src="../../../../../xampp/htdocs/ADISE/g.png" width="700" height="300">
	<form action="login.php" method="post">
		<h2>LOGIN</h2>
		<?php if(isset($_GET['error'])) { ?>
			<p class="error"><?php echo $_GET['error']; ?></p>
		<?php } ?>
		<label>User Name</label>
		<input type="test" name="uname" placeholder="User Name">
		<br>
		<label>Password</label>
		<input type="password" name="password" placeholder="Password">
		
		<button type="submit">LOGIN</button>
	 </form>
</body>
</html>
