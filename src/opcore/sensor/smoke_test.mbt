///|
/// # Smoke tests - auto-generated
///
test "lidar_proc_lidar_proc_make_labeled_point_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_make_labeled_point(1.0, 1.0, 1)
}
///|
test "lidar_proc_lidar_proc_make_matrix_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_make_matrix(1, 1, 1.0)
}
///|
test "lidar_proc_lidar_proc_make_point_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_make_point(1.0, 1.0)
}
///|
test "lidar_proc_lidar_proc_make_series_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "lidar_proc_lidar_proc_make_vector_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_make_vector([1.0, 2.0, 3.0])
}
///|
test "lidar_proc_lidar_proc_matrix_identity_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_matrix_identity(1)
}
///|
test "lidar_proc_lidar_proc_vector_zero_smoke" {
  let _ = @sensor.lidar_proc_lidar_proc_vector_zero(1)
}
///|
test "radar_proc_radar_proc_make_labeled_point_smoke" {
  let _ = @sensor.radar_proc_radar_proc_make_labeled_point(1.0, 1.0, 1)
}
///|
test "radar_proc_radar_proc_make_matrix_smoke" {
  let _ = @sensor.radar_proc_radar_proc_make_matrix(1, 1, 1.0)
}
///|
test "radar_proc_radar_proc_make_point_smoke" {
  let _ = @sensor.radar_proc_radar_proc_make_point(1.0, 1.0)
}
