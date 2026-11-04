///|
/// # Smoke tests - auto-generated
///
test "coord_coord_id_smoke" {
  let _ = @spatial.coord_coord_id()
}
///|
test "coord_identity_affine_smoke" {
  let _ = @spatial.coord_identity_affine()
}
///|
test "coord_make_affine_smoke" {
  let _ = @spatial.coord_make_affine(1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
}
///|
test "coord_make_geodetic_smoke" {
  let _ = @spatial.coord_make_geodetic(1.0, 1.0)
}
///|
test "coord_make_projected_smoke" {
  let _ = @spatial.coord_make_projected(1.0, 1.0)
}
///|
test "density_make_density_result_smoke" {
  let _ = @spatial.density_make_density_result(1.0, 1.0, 1.0)
}
///|
test "geocoding_geocoding_id_smoke" {
  let _ = @spatial.geocoding_geocoding_id()
}
///|
test "geocoding_make_address_smoke" {
  let _ = @spatial.geocoding_make_address("test", "test", "test", "test", "test")
}
///|
test "geocoding_make_geo_coord_smoke" {
  let _ = @spatial.geocoding_make_geo_coord(1.0, 1.0)
}
///|
test "groundwater_make_darcy_flow_result_smoke" {
  let _ = @spatial.groundwater_make_darcy_flow_result(1.0, 1.0, 1.0, 1.0)
}
