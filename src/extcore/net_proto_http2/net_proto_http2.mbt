///===
/// extcore/net_proto_http2

pub(all) struct Netprotohttp2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http2_make_point(x : Double, y : Double) -> Netprotohttp2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http2_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp2Point {
  { x, y, z, label: 0 }
}

pub fn Netprotohttp2Point::x(self : Netprotohttp2Point) -> Double { self.x }

pub fn Netprotohttp2Point::y(self : Netprotohttp2Point) -> Double { self.y }

pub fn Netprotohttp2Point::z(self : Netprotohttp2Point) -> Double { self.z }

pub fn Netprotohttp2Point::label(self : Netprotohttp2Point) -> Int { self.label }

pub fn Netprotohttp2Point::dist(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Netprotohttp2Point::add(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Netprotohttp2Point::sub(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Netprotohttp2Point::scale(self : Netprotohttp2Point, s : Double) -> Netprotohttp2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Netprotohttp2Point::dot(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Netprotohttp2Point::cross(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Netprotohttp2Point::norm(self : Netprotohttp2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Netprotohttp2Point::normalize(self : Netprotohttp2Point) -> Netprotohttp2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp2Point::negate(self : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Netprotohttp2Point::mid(self : Netprotohttp2Point, other : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Netprotohttp2Point::lerp(self : Netprotohttp2Point, other : Netprotohttp2Point, t : Double) -> Netprotohttp2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Netprotohttp2Point::to_string(self : Netprotohttp2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Netprotohttp2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http2_make_series(vals : Array[Double], name : String) -> Netprotohttp2Series {
  { vals, name, meta: 0 }
}

pub fn Netprotohttp2Series::len(self : Netprotohttp2Series) -> Int { self.vals.length() }

pub fn Netprotohttp2Series::sum(self : Netprotohttp2Series) -> Double { @_common.sum(self.vals) }

pub fn Netprotohttp2Series::mean(self : Netprotohttp2Series) -> Double { @_common.mean(self.vals) }

pub fn Netprotohttp2Series::min(self : Netprotohttp2Series) -> Double { @_common.min(self.vals) }

pub fn Netprotohttp2Series::max(self : Netprotohttp2Series) -> Double { @_common.max(self.vals) }

pub fn Netprotohttp2Series::range(self : Netprotohttp2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Netprotohttp2Series::variance(self : Netprotohttp2Series) -> Double { @_common.variance(self.vals) }

pub fn Netprotohttp2Series::std(self : Netprotohttp2Series) -> Double { @_common.std(self.vals) }

pub fn Netprotohttp2Series::median(self : Netprotohttp2Series) -> Double { @_common.median(self.vals) }

pub fn Netprotohttp2Series::scale(self : Netprotohttp2Series, f : Double) -> Netprotohttp2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Netprotohttp2Series::add(self : Netprotohttp2Series, other : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Netprotohttp2Series::sub(self : Netprotohttp2Series, other : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Netprotohttp2Series::normalize(self : Netprotohttp2Series) -> Netprotohttp2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Netprotohttp2Series::cumsum(self : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Netprotohttp2Series::to_string(self : Netprotohttp2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http2_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http2_matrix_identity(n : Int) -> Netprotohttp2Matrix {
  let m = net_proto_http2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Netprotohttp2Matrix::get(self : Netprotohttp2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Netprotohttp2Matrix::transpose(self : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Netprotohttp2Matrix::add(self : Netprotohttp2Matrix, other : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_http2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Netprotohttp2Matrix::scale(self : Netprotohttp2Matrix, s : Double) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Netprotohttp2Matrix::multiply(self : Netprotohttp2Matrix, other : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if self.cols != other.rows { return net_proto_http2_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_http2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Netprotohttp2Matrix::trace(self : Netprotohttp2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Netprotohttp2Matrix::det(self : Netprotohttp2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Netprotohttp2Matrix::norm(self : Netprotohttp2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Netprotohttp2Matrix::to_string(self : Netprotohttp2Matrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Netprotohttp2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http2_make_vector(comps : Array[Double]) -> Netprotohttp2Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http2_vector_zero(dim : Int) -> Netprotohttp2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Netprotohttp2Vector::add(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp2Vector::sub(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp2Vector::scale(self : Netprotohttp2Vector, s : Double) -> Netprotohttp2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Netprotohttp2Vector::dot(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Netprotohttp2Vector::norm(self : Netprotohttp2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Netprotohttp2Vector::normalize(self : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp2Vector::dist(self : Netprotohttp2Vector, other : Netprotohttp2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Netprotohttp2Vector::to_string(self : Netprotohttp2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_http2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_http2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_http2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_http2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_http2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_http2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_http2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_http2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_http2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_http2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_http2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_http2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_http2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_http2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_http2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_http2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_http2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_http2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_http2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_http2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_http2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_http2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_http2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_http2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_http2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_http2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_http2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_http2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Netprotohttp2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_frame_make(size : Int) -> Netprotohttp2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_frame_len(s : Netprotohttp2Frame) -> Int { s.size }

pub fn net_proto_http2_frame_get(s : Netprotohttp2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_frame_set(s : Netprotohttp2Frame, i : Int, v : Double) -> Netprotohttp2Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_frame_sum(s : Netprotohttp2Frame) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_frame_mean(s : Netprotohttp2Frame) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_frame_scale(s : Netprotohttp2Frame, f : Double) -> Netprotohttp2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_frame_add(a : Netprotohttp2Frame, b : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_frame_copy(s : Netprotohttp2Frame) -> Netprotohttp2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_frame_fill(s : Netprotohttp2Frame, v : Double) -> Netprotohttp2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_frame_min(s : Netprotohttp2Frame) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_frame_max(s : Netprotohttp2Frame) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_frame_to_string(s : Netprotohttp2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_table_make(size : Int) -> Netprotohttp2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_table_len(s : Netprotohttp2Table) -> Int { s.size }

pub fn net_proto_http2_table_get(s : Netprotohttp2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_table_set(s : Netprotohttp2Table, i : Int, v : Double) -> Netprotohttp2Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_table_sum(s : Netprotohttp2Table) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_table_mean(s : Netprotohttp2Table) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_table_scale(s : Netprotohttp2Table, f : Double) -> Netprotohttp2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_table_add(a : Netprotohttp2Table, b : Netprotohttp2Table) -> Netprotohttp2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_table_copy(s : Netprotohttp2Table) -> Netprotohttp2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_table_fill(s : Netprotohttp2Table, v : Double) -> Netprotohttp2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_table_min(s : Netprotohttp2Table) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_table_max(s : Netprotohttp2Table) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_table_to_string(s : Netprotohttp2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_graphn_make(size : Int) -> Netprotohttp2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_graphn_len(s : Netprotohttp2GraphN) -> Int { s.size }

pub fn net_proto_http2_graphn_get(s : Netprotohttp2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_graphn_set(s : Netprotohttp2GraphN, i : Int, v : Double) -> Netprotohttp2GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_graphn_sum(s : Netprotohttp2GraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_graphn_mean(s : Netprotohttp2GraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_graphn_scale(s : Netprotohttp2GraphN, f : Double) -> Netprotohttp2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_graphn_add(a : Netprotohttp2GraphN, b : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_graphn_copy(s : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_graphn_fill(s : Netprotohttp2GraphN, v : Double) -> Netprotohttp2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_graphn_min(s : Netprotohttp2GraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_graphn_max(s : Netprotohttp2GraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_graphn_to_string(s : Netprotohttp2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_node_make(size : Int) -> Netprotohttp2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_node_len(s : Netprotohttp2Node) -> Int { s.size }

pub fn net_proto_http2_node_get(s : Netprotohttp2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_node_set(s : Netprotohttp2Node, i : Int, v : Double) -> Netprotohttp2Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_node_sum(s : Netprotohttp2Node) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_node_mean(s : Netprotohttp2Node) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_node_scale(s : Netprotohttp2Node, f : Double) -> Netprotohttp2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_node_add(a : Netprotohttp2Node, b : Netprotohttp2Node) -> Netprotohttp2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_node_copy(s : Netprotohttp2Node) -> Netprotohttp2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_node_fill(s : Netprotohttp2Node, v : Double) -> Netprotohttp2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_node_min(s : Netprotohttp2Node) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_node_max(s : Netprotohttp2Node) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_node_to_string(s : Netprotohttp2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_edge_make(size : Int) -> Netprotohttp2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_edge_len(s : Netprotohttp2Edge) -> Int { s.size }

pub fn net_proto_http2_edge_get(s : Netprotohttp2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_edge_set(s : Netprotohttp2Edge, i : Int, v : Double) -> Netprotohttp2Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_edge_sum(s : Netprotohttp2Edge) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_edge_mean(s : Netprotohttp2Edge) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_edge_scale(s : Netprotohttp2Edge, f : Double) -> Netprotohttp2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_edge_add(a : Netprotohttp2Edge, b : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_edge_copy(s : Netprotohttp2Edge) -> Netprotohttp2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_edge_fill(s : Netprotohttp2Edge, v : Double) -> Netprotohttp2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_edge_min(s : Netprotohttp2Edge) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_edge_max(s : Netprotohttp2Edge) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_edge_to_string(s : Netprotohttp2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_path_make(size : Int) -> Netprotohttp2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_path_len(s : Netprotohttp2Path) -> Int { s.size }

pub fn net_proto_http2_path_get(s : Netprotohttp2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_path_set(s : Netprotohttp2Path, i : Int, v : Double) -> Netprotohttp2Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_path_sum(s : Netprotohttp2Path) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_path_mean(s : Netprotohttp2Path) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_path_scale(s : Netprotohttp2Path, f : Double) -> Netprotohttp2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_path_add(a : Netprotohttp2Path, b : Netprotohttp2Path) -> Netprotohttp2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_path_copy(s : Netprotohttp2Path) -> Netprotohttp2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_path_fill(s : Netprotohttp2Path, v : Double) -> Netprotohttp2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_path_min(s : Netprotohttp2Path) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_path_max(s : Netprotohttp2Path) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_path_to_string(s : Netprotohttp2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cluster_make(size : Int) -> Netprotohttp2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cluster_len(s : Netprotohttp2Cluster) -> Int { s.size }

pub fn net_proto_http2_cluster_get(s : Netprotohttp2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cluster_set(s : Netprotohttp2Cluster, i : Int, v : Double) -> Netprotohttp2Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cluster_sum(s : Netprotohttp2Cluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_cluster_mean(s : Netprotohttp2Cluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_cluster_scale(s : Netprotohttp2Cluster, f : Double) -> Netprotohttp2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cluster_add(a : Netprotohttp2Cluster, b : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_cluster_copy(s : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cluster_fill(s : Netprotohttp2Cluster, v : Double) -> Netprotohttp2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cluster_min(s : Netprotohttp2Cluster) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_cluster_max(s : Netprotohttp2Cluster) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_cluster_to_string(s : Netprotohttp2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_model_make(size : Int) -> Netprotohttp2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_model_len(s : Netprotohttp2Model) -> Int { s.size }

pub fn net_proto_http2_model_get(s : Netprotohttp2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_model_set(s : Netprotohttp2Model, i : Int, v : Double) -> Netprotohttp2Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_model_sum(s : Netprotohttp2Model) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_model_mean(s : Netprotohttp2Model) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_model_scale(s : Netprotohttp2Model, f : Double) -> Netprotohttp2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_model_add(a : Netprotohttp2Model, b : Netprotohttp2Model) -> Netprotohttp2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_model_copy(s : Netprotohttp2Model) -> Netprotohttp2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_model_fill(s : Netprotohttp2Model, v : Double) -> Netprotohttp2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_model_min(s : Netprotohttp2Model) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_model_max(s : Netprotohttp2Model) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_model_to_string(s : Netprotohttp2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_layer_make(size : Int) -> Netprotohttp2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_layer_len(s : Netprotohttp2Layer) -> Int { s.size }

pub fn net_proto_http2_layer_get(s : Netprotohttp2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_layer_set(s : Netprotohttp2Layer, i : Int, v : Double) -> Netprotohttp2Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_layer_sum(s : Netprotohttp2Layer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_layer_mean(s : Netprotohttp2Layer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_layer_scale(s : Netprotohttp2Layer, f : Double) -> Netprotohttp2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_layer_add(a : Netprotohttp2Layer, b : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_layer_copy(s : Netprotohttp2Layer) -> Netprotohttp2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_layer_fill(s : Netprotohttp2Layer, v : Double) -> Netprotohttp2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_layer_min(s : Netprotohttp2Layer) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_layer_max(s : Netprotohttp2Layer) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_layer_to_string(s : Netprotohttp2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_buffer_make(size : Int) -> Netprotohttp2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_buffer_len(s : Netprotohttp2Buffer) -> Int { s.size }

pub fn net_proto_http2_buffer_get(s : Netprotohttp2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_buffer_set(s : Netprotohttp2Buffer, i : Int, v : Double) -> Netprotohttp2Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_buffer_sum(s : Netprotohttp2Buffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_buffer_mean(s : Netprotohttp2Buffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_buffer_scale(s : Netprotohttp2Buffer, f : Double) -> Netprotohttp2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_buffer_add(a : Netprotohttp2Buffer, b : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_buffer_copy(s : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_buffer_fill(s : Netprotohttp2Buffer, v : Double) -> Netprotohttp2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_buffer_min(s : Netprotohttp2Buffer) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_buffer_max(s : Netprotohttp2Buffer) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_buffer_to_string(s : Netprotohttp2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cursor_make(size : Int) -> Netprotohttp2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cursor_len(s : Netprotohttp2Cursor) -> Int { s.size }

pub fn net_proto_http2_cursor_get(s : Netprotohttp2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cursor_set(s : Netprotohttp2Cursor, i : Int, v : Double) -> Netprotohttp2Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cursor_sum(s : Netprotohttp2Cursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_cursor_mean(s : Netprotohttp2Cursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_cursor_scale(s : Netprotohttp2Cursor, f : Double) -> Netprotohttp2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cursor_add(a : Netprotohttp2Cursor, b : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_cursor_copy(s : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cursor_fill(s : Netprotohttp2Cursor, v : Double) -> Netprotohttp2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_cursor_min(s : Netprotohttp2Cursor) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_cursor_max(s : Netprotohttp2Cursor) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_cursor_to_string(s : Netprotohttp2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_view_make(size : Int) -> Netprotohttp2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_view_len(s : Netprotohttp2View) -> Int { s.size }

pub fn net_proto_http2_view_get(s : Netprotohttp2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_view_set(s : Netprotohttp2View, i : Int, v : Double) -> Netprotohttp2View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_view_sum(s : Netprotohttp2View) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_view_mean(s : Netprotohttp2View) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_view_scale(s : Netprotohttp2View, f : Double) -> Netprotohttp2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_view_add(a : Netprotohttp2View, b : Netprotohttp2View) -> Netprotohttp2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_view_copy(s : Netprotohttp2View) -> Netprotohttp2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_view_fill(s : Netprotohttp2View, v : Double) -> Netprotohttp2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_view_min(s : Netprotohttp2View) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_view_max(s : Netprotohttp2View) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_view_to_string(s : Netprotohttp2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_range_make(size : Int) -> Netprotohttp2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_range_len(s : Netprotohttp2Range) -> Int { s.size }

pub fn net_proto_http2_range_get(s : Netprotohttp2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_range_set(s : Netprotohttp2Range, i : Int, v : Double) -> Netprotohttp2Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_range_sum(s : Netprotohttp2Range) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_range_mean(s : Netprotohttp2Range) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_range_scale(s : Netprotohttp2Range, f : Double) -> Netprotohttp2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_range_add(a : Netprotohttp2Range, b : Netprotohttp2Range) -> Netprotohttp2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_range_copy(s : Netprotohttp2Range) -> Netprotohttp2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_range_fill(s : Netprotohttp2Range, v : Double) -> Netprotohttp2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_range_min(s : Netprotohttp2Range) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_range_max(s : Netprotohttp2Range) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_range_to_string(s : Netprotohttp2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_slice_make(size : Int) -> Netprotohttp2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_slice_len(s : Netprotohttp2Slice) -> Int { s.size }

pub fn net_proto_http2_slice_get(s : Netprotohttp2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_slice_set(s : Netprotohttp2Slice, i : Int, v : Double) -> Netprotohttp2Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http2_slice_sum(s : Netprotohttp2Slice) -> Double { @_common.sum(s.data) }

pub fn net_proto_http2_slice_mean(s : Netprotohttp2Slice) -> Double { @_common.mean(s.data) }

pub fn net_proto_http2_slice_scale(s : Netprotohttp2Slice, f : Double) -> Netprotohttp2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_slice_add(a : Netprotohttp2Slice, b : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http2_slice_copy(s : Netprotohttp2Slice) -> Netprotohttp2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_slice_fill(s : Netprotohttp2Slice, v : Double) -> Netprotohttp2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http2_slice_min(s : Netprotohttp2Slice) -> Double { @_common.min(s.data) }

pub fn net_proto_http2_slice_max(s : Netprotohttp2Slice) -> Double { @_common.max(s.data) }

pub fn net_proto_http2_slice_to_string(s : Netprotohttp2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

