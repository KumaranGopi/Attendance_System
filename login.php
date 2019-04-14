<?php
if(isset($_POST['login'])){
    include 'header/db.php';
    $user_name=$_POST['username'];
    $passwd=$_POST['password'];

    $sql="select * from login where user_name='$user_name'";
    $result=mysqli_query($con,$sql);
    $result_check=mysqli_num_rows($result);
    $row_pass=mysqli_fetch_assoc($result);
    if($result_check < 1){
        header("LOCATION: login.html");
        exit();
    }else{
        $temp_pass=$row_pass['pass_wd'];
        $compare=strcmp($passwd,$temp_pass);
        if($compare==0){
            if ($row_pass['teach_or_std']=='1') {
                header("LOCATION: teacher.php");
                session_start();
                $_SESSION["user_id"]=$user_name;
            }else{
                header("LOCATION: student.php");
                session_start();
                $_SESSION["user_id"]=$user_name;
            }
        }
    }
}
?>