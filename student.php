<?php
session_start();
$users_name=$_SESSION["user_id"];
include 'login.php';
include_once 'header/db.php';
//echo $users_name;
//retrive student id from database for current users
$fetch_std_id_sql="select user_id from login where user_name='$users_name'";
$fetch_std_id_sqldata=mysqli_query($con,$fetch_std_id_sql);
$fetch_std_id=mysqli_fetch_array($fetch_std_id_sqldata);
$std_id=$fetch_std_id['user_id'];//echo $std_id;
//to retrive attendance details based on the user id
$fetch_std_attendance_sql="select att_date,att_prs_abs,cls_id from attendance where std_id='$std_id'";
$fetch_std_attendance_result=mysqli_query($con,$fetch_std_attendance_sql);
$fetch_std_attendance_num_rows=mysqli_num_rows($fetch_std_attendance_result);
//echo $fetch_std_attendance_num_rows;
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Students Attendance details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
    <div style="margin:50px">
        <table align="center" style="border:2px solid black">
        <tr>
            <th>Date</th>
            <th>Attendance</th>
        </tr>
        <?php
            while ($fetch_std_attendance=mysqli_fetch_assoc($fetch_std_attendance_result)) {
                if($fetch_std_attendance['att_prs_abs']=='1'){
                    $prs="P";
                    echo '<tr><td>'.$fetch_std_attendance['att_date'].'</td><td style="text-align:center">'.$prs.'</td></tr>';
                }else{
                    $abs="A";
                    echo '<tr><td>'.$fetch_std_attendance['att_date'].'</td><td style="text-align:center">'.$abs.'</td></tr>';
                }
            }
        ?>
        </table>
    </div>    
</body>
</html>