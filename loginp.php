<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Backgammon game </title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<style>


body {
  background-image:url('bg2.jpg');
    background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  height: 100%;
  width:100%;
  background-size:cover;
}

.loginbox {
	 
	 width:320px;
	 height:420px;
	 background-color:white;
	 top:40%;
	 left:50%;
	 position:absolute;
	 transform:translate(-50%,-50px);
	 box-sizing:border-box;
	 
}

.logo{
	
	width:300px;
	height:200px;
	position:absolute;
	margin-left:3.5%;
    margin-right: 3.5%;
    display: block;
}


.loginbox{
    width: 520px;
    height: 420px;
    background: #000;
    color: #fff;
    top: 50%;
    left: 50%;
    position: absolute;
    transform: translate(-50%,-50%);
    box-sizing: border-box;
    padding: 70px 30px;
}


h1{
    margin: 0;
    padding: 0 0 20px;
    text-align: center;
    font-size: 22px;
}

.loginbox p{
    margin: 0;
    padding: 0;
    font-weight: bold;
}

.loginbox input{
    width: 100%;
    margin-bottom: 20px;
}
.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 30px 0;
}

.txtb input{
  font-size: 15px;
  color: #333;
  border: none;
  width: 100%;
  outline: none;
  background: none;
  padding: 0 5px;
  height: 40px;
}

.txtb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
}

.txtb span::after{
  content: '';
  position: absolute;
  width: 0%;
  height: 2px;
  background: linear-gradient(120deg,#ff9900,#990000);
  transition: .5s;
}

.focus + span::before{
  top: -5px;
}
.focus + span::after{
  width: 100%;
}

     <?php 
	$con = mysqli_connect("localhost","root","")

?>


.loginbox input[type=text], input[type=password]
{
    border: none;
    border-bottom: 1px solid #fff;
    background: transparent;
    outline: none;
    height: 40px;
    color: #fff;
    font-size: 16px;
}
.loginbox input[type=submit]
{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background: linear-gradient(120deg,#ff9900,#990000);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;}
  
  
.loginbox input[type=submit]:hover
{
    background-position: right;}
    
.loginbox a{
    text-decoration: none;
    font-size: 12px;
    line-height: 20px;
    color: darkgrey;
}

.loginbox a:hover
{
    color: #ffc107;
}




.auto-style1 {
	margin-left: auto;
  	margin-right: auto;
 	display: block;
	height:80px;
	width:211px;
	margin-top:-90px;
}




</style>


<link rel="icon" href="g.png">

</head>

<body>


 <div class="loginbox">
    <img src="g.png" class="auto-style1">
        <form method="post" action="dbconnect.php">
       
        
            <div class="txtb">
          <input type="text" name="username"  id="username">
          <span data-placeholder="Username"></span>
        </div>

        <div class="txtb">
          <input type="password" name="password" id="password">
          <span data-placeholder="Password"></span>
        </div>
             <input type="submit" name="SUBMIT" value="Login">
            <a href="#">Forgot your password?</a><br> <a href="#">Don't have an account?</a>
        </form>
        
    </div>
    
      <script type="text/javascript">
      $(".txtb input").on("focus",function(){
        $(this).addClass("focus");
      });

      $(".txtb input").on("blur",function(){
        if($(this).val() == "")
        $(this).removeClass("focus");
      });

      </script>

</body>

</html>