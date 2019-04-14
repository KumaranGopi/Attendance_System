<?php
session_start();
include 'header/db.php';
include 'login.php';
$users_name=$_SESSION["user_id"];
$fetch_std_id_sql="select user_id from login where user_name='$users_name'";
$fetch_std_id_sqldata=mysqli_query($con,$fetch_std_id_sql);
$fetch_std_id=mysqli_fetch_array($fetch_std_id_sqldata);
$teach_id=$fetch_std_id['user_id'];
$class_id_sql="select class.cls_id,class.cls_name from teacher,class where teacher.teach_id='$teach_id' and class.teach_id=teacher.teach_id";
$class_id_sqlresult=mysqli_query($con,$class_id_sql);
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Attendance Entry</title>
    </head>
    <body>
        <form method="get" action="">
            <table>
                <tr>
                <td>Choose the class</td>
                <td>
                    <select name="cls_id">
                    <?php
                    while($class_id_data=mysqli_fetch_array($class_id_sqlresult)){
                    echo "<option value=".$class_id_data['cls_id'].">".$class_id_data['cls_name']."</option>";
                    }
                    ?>
                    </select>
                </td>
                <td><input type="submit" id="cls_submit" name="cls_submit" value="Submit"></td>
                </tr>
            </table>
            <table>
                <?php
                if(isset($_GET['cls_submit'])){
                    $class_id=$_GET['cls_id'];
                    $student_details_sqlstmt="select Students.std_id,Students.std_name from Students where Students.class_id='$class_id'";
                    $student_details_sqldata=mysqli_query($con,$student_details_sqlstmt);
                    while ($students=mysqli_fetch_assoc($student_details_sqldata)){
                        echo "<tr><td>".$students['std_name']."</td><td><input type=checkbox name=std_list[] value=".$students['std_id']."></td></tr>";
                    }
                }
                ?>
                <tr>
                    <td colspan=2><input type="submit" value="Submit" name="att_submit"></td>
                </tr>
                <?php
                    if(isset($_GET['att_submit'])){
                        $checked_abs_or_prs = $_GET['std_list'];
                        $class_id=$_GET['cls_id'];
                        $student_details_sqlstmt="select Students.std_id,Students.std_name from Students where Students.class_id='$class_id'";
                        $student_details_sqldata=mysqli_query($con,$student_details_sqlstmt);
                        $all_std_id;
                        while ($students=mysqli_fetch_assoc($student_details_sqldata)){
                            $all_std_id[]=$students['std_id'];
                        }
                        $not_present_checker=array_diff($all_std_id,$checked_abs_or_prs);
                        $not_pres_app=array();
                        $not_pres_merg=array_merge($not_pres_app,$not_present_checker);
                        $prs=count($checked_abs_or_prs);
                        $abs=count($not_pres_merg);

                        print_r($checked_abs_or_prs);print($prs ."". $abs) ;
                        print_r($not_pres_merg);
                        if($prs!=0){
                            for($i=0;$i<$prs;$i++){
                                $sql_prs_ins="insert into attendance(att_date,att_prs_abs,cls_id,std_id,teach_id) VALUES(CURRENT_DATE,1,$class_id,$checked_abs_or_prs[$i],$teach_id)";
                                $ins_success=mysqli_query($con,$sql_prs_ins);
                            }
                        }
                        if($abs!=0){
                            for($i=0;$i<$abs;$i++){
                                $sql_abs_ins="insert into attendance(att_date,att_prs_abs,cls_id,std_id,teach_id) VALUES(CURRENT_DATE,0,$class_id,$not_pres_merg[$i],$teach_id)";
                                $ins_success=mysqli_query($con,$sql_abs_ins);
                                // echo($not_present_checker[$i]."||");
                                // print($sql_abs_ins."\n");
                           }
                        }
                        // for ($i=0; $i <=$abs; $i++) { 
                        //     print($not_pres_merg[$i]);
                        // }
                    }
                ?>
            </table>
        </form>
    </body>
</html>