///|
/// # Smoke tests - auto-generated
///
test "net_proto_grpc_make_matrix_smoke" {
  let _ = @proto.net_proto_grpc_make_matrix(1, 1, 1.0)
}
///|
test "net_proto_grpc_make_point_smoke" {
  let _ = @proto.net_proto_grpc_make_point(1.0, 1.0)
}
///|
test "net_proto_grpc_make_point3_smoke" {
  let _ = @proto.net_proto_grpc_make_point3(1.0, 1.0, 1.0)
}
///|
test "net_proto_grpc_make_series_smoke" {
  let _ = @proto.net_proto_grpc_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "net_proto_grpc_make_vector_smoke" {
  let _ = @proto.net_proto_grpc_make_vector([1.0, 2.0, 3.0])
}
///|
test "net_proto_grpc_matrix_identity_smoke" {
  let _ = @proto.net_proto_grpc_matrix_identity(1)
}
///|
test "net_proto_grpc_vector_zero_smoke" {
  let _ = @proto.net_proto_grpc_vector_zero(1)
}
///|
test "net_proto_http2_make_matrix_smoke" {
  let _ = @proto.net_proto_http2_make_matrix(1, 1, 1.0)
}
///|
test "net_proto_http2_make_point_smoke" {
  let _ = @proto.net_proto_http2_make_point(1.0, 1.0)
}
///|
test "net_proto_http2_make_point3_smoke" {
  let _ = @proto.net_proto_http2_make_point3(1.0, 1.0, 1.0)
}
