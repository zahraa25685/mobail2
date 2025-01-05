<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
header("Content-Type: application/json");


$con = mysqli_connect("localhost", "id11880858_user2", "password", "id11880858_ice_cream_store");


if (mysqli_connect_errno()) {
    echo json_encode(["error" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit();
}


$sql = "SELECT id, name, type, price_per_kg FROM ice_cream";
if ($result = mysqli_query($con, $sql)) {
    $emparray = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $emparray[] = $row;
    }

    echo json_encode($emparray);

   
    mysqli_free_result($result);
}
mysqli_close($con);
?>
