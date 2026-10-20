///===
/// extcore/net_proto_http3

pub(all) struct Netprotohttp3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http3_make_point(x : Double, y : Double) -> Netprotohttp3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http3_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp3Point {
  { x, y, z, label: 0 }
}

pub fn Netprotohttp3Point::x(self : Netprotohttp3Point) -> Double { self.x }

pub fn Netprotohttp3Point::y(self : Netprotohttp3Point) -> Double { self.y }

pub fn Netprotohttp3Point::z(self : Netprotohttp3Point) -> Double { self.z }

pub fn Netprotohttp3Point::label(self : Netprotohttp3Point) -> Int { self.label }

pub fn Netprotohttp3Point::dist(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Netprotohttp3Point::add(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Netprotohttp3Point::sub(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Netprotohttp3Point::scale(self : Netprotohttp3Point, s : Double) -> Netprotohttp3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Netprotohttp3Point::dot(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Netprotohttp3Point::cross(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Netprotohttp3Point::norm(self : Netprotohttp3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Netprotohttp3Point::normalize(self : Netprotohttp3Point) -> Netprotohttp3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp3Point::negate(self : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Netprotohttp3Point::mid(self : Netprotohttp3Point, other : Netprotohttp3Point) -> Netprotohttp3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Netprotohttp3Point::lerp(self : Netprotohttp3Point, other : Netprotohttp3Point, t : Double) -> Netprotohttp3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Netprotohttp3Point::to_string(self : Netprotohttp3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Netprotohttp3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http3_make_series(vals : Array[Double], name : String) -> Netprotohttp3Series {
  { vals, name, meta: 0 }
}

pub fn Netprotohttp3Series::len(self : Netprotohttp3Series) -> Int { self.vals.length() }

pub fn Netprotohttp3Series::sum(self : Netprotohttp3Series) -> Double { @_common.sum(self.vals) }

pub fn Netprotohttp3Series::mean(self : Netprotohttp3Series) -> Double { @_common.mean(self.vals) }

pub fn Netprotohttp3Series::min(self : Netprotohttp3Series) -> Double { @_common.min(self.vals) }

pub fn Netprotohttp3Series::max(self : Netprotohttp3Series) -> Double { @_common.max(self.vals) }

pub fn Netprotohttp3Series::range(self : Netprotohttp3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Netprotohttp3Series::variance(self : Netprotohttp3Series) -> Double { @_common.variance(self.vals) }

pub fn Netprotohttp3Series::std(self : Netprotohttp3Series) -> Double { @_common.std(self.vals) }

pub fn Netprotohttp3Series::median(self : Netprotohttp3Series) -> Double { @_common.median(self.vals) }

pub fn Netprotohttp3Series::scale(self : Netprotohttp3Series, f : Double) -> Netprotohttp3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Netprotohttp3Series::add(self : Netprotohttp3Series, other : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Netprotohttp3Series::sub(self : Netprotohttp3Series, other : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Netprotohttp3Series::normalize(self : Netprotohttp3Series) -> Netprotohttp3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Netprotohttp3Series::cumsum(self : Netprotohttp3Series) -> Netprotohttp3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Netprotohttp3Series::to_string(self : Netprotohttp3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http3_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http3_matrix_identity(n : Int) -> Netprotohttp3Matrix {
  let m = net_proto_http3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Netprotohttp3Matrix::get(self : Netprotohttp3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Netprotohttp3Matrix::transpose(self : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  let result = net_proto_http3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Netprotohttp3Matrix::add(self : Netprotohttp3Matrix, other : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_http3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Netprotohttp3Matrix::scale(self : Netprotohttp3Matrix, s : Double) -> Netprotohttp3Matrix {
  let result = net_proto_http3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Netprotohttp3Matrix::multiply(self : Netprotohttp3Matrix, other : Netprotohttp3Matrix) -> Netprotohttp3Matrix {
  if self.cols != other.rows { return net_proto_http3_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_http3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Netprotohttp3Matrix::trace(self : Netprotohttp3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Netprotohttp3Matrix::det(self : Netprotohttp3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Netprotohttp3Matrix::norm(self : Netprotohttp3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Netprotohttp3Matrix::to_string(self : Netprotohttp3Matrix) -> String {
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

pub(all) struct Netprotohttp3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http3_make_vector(comps : Array[Double]) -> Netprotohttp3Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http3_vector_zero(dim : Int) -> Netprotohttp3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Netprotohttp3Vector::add(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp3Vector::sub(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Netprotohttp3Vector::scale(self : Netprotohttp3Vector, s : Double) -> Netprotohttp3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Netprotohttp3Vector::dot(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Netprotohttp3Vector::norm(self : Netprotohttp3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Netprotohttp3Vector::normalize(self : Netprotohttp3Vector) -> Netprotohttp3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Netprotohttp3Vector::dist(self : Netprotohttp3Vector, other : Netprotohttp3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Netprotohttp3Vector::to_string(self : Netprotohttp3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http3_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_http3_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_http3_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_http3_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_http3_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_http3_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_http3_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_http3_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_http3_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_http3_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_http3_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_http3_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_http3_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_http3_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_http3_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_http3_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_http3_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_http3_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_http3_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_http3_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_http3_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_http3_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_http3_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_http3_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_http3_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_http3_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_http3_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_http3_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_http3_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Netprotohttp3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_frame_make(size : Int) -> Netprotohttp3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_frame_len(s : Netprotohttp3Frame) -> Int { s.size }

pub fn net_proto_http3_frame_get(s : Netprotohttp3Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_frame_set(s : Netprotohttp3Frame, i : Int, v : Double) -> Netprotohttp3Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_frame_sum(s : Netprotohttp3Frame) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_frame_mean(s : Netprotohttp3Frame) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_frame_scale(s : Netprotohttp3Frame, f : Double) -> Netprotohttp3Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_frame_add(a : Netprotohttp3Frame, b : Netprotohttp3Frame) -> Netprotohttp3Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_frame_copy(s : Netprotohttp3Frame) -> Netprotohttp3Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_frame_fill(s : Netprotohttp3Frame, v : Double) -> Netprotohttp3Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_frame_min(s : Netprotohttp3Frame) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_frame_max(s : Netprotohttp3Frame) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_frame_to_string(s : Netprotohttp3Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_table_make(size : Int) -> Netprotohttp3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_table_len(s : Netprotohttp3Table) -> Int { s.size }

pub fn net_proto_http3_table_get(s : Netprotohttp3Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_table_set(s : Netprotohttp3Table, i : Int, v : Double) -> Netprotohttp3Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_table_sum(s : Netprotohttp3Table) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_table_mean(s : Netprotohttp3Table) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_table_scale(s : Netprotohttp3Table, f : Double) -> Netprotohttp3Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_table_add(a : Netprotohttp3Table, b : Netprotohttp3Table) -> Netprotohttp3Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_table_copy(s : Netprotohttp3Table) -> Netprotohttp3Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_table_fill(s : Netprotohttp3Table, v : Double) -> Netprotohttp3Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_table_min(s : Netprotohttp3Table) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_table_max(s : Netprotohttp3Table) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_table_to_string(s : Netprotohttp3Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_graphn_make(size : Int) -> Netprotohttp3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_graphn_len(s : Netprotohttp3GraphN) -> Int { s.size }

pub fn net_proto_http3_graphn_get(s : Netprotohttp3GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_graphn_set(s : Netprotohttp3GraphN, i : Int, v : Double) -> Netprotohttp3GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_graphn_sum(s : Netprotohttp3GraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_graphn_mean(s : Netprotohttp3GraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_graphn_scale(s : Netprotohttp3GraphN, f : Double) -> Netprotohttp3GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_graphn_add(a : Netprotohttp3GraphN, b : Netprotohttp3GraphN) -> Netprotohttp3GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_graphn_copy(s : Netprotohttp3GraphN) -> Netprotohttp3GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_graphn_fill(s : Netprotohttp3GraphN, v : Double) -> Netprotohttp3GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_graphn_min(s : Netprotohttp3GraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_graphn_max(s : Netprotohttp3GraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_graphn_to_string(s : Netprotohttp3GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_node_make(size : Int) -> Netprotohttp3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_node_len(s : Netprotohttp3Node) -> Int { s.size }

pub fn net_proto_http3_node_get(s : Netprotohttp3Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_node_set(s : Netprotohttp3Node, i : Int, v : Double) -> Netprotohttp3Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_node_sum(s : Netprotohttp3Node) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_node_mean(s : Netprotohttp3Node) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_node_scale(s : Netprotohttp3Node, f : Double) -> Netprotohttp3Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_node_add(a : Netprotohttp3Node, b : Netprotohttp3Node) -> Netprotohttp3Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_node_copy(s : Netprotohttp3Node) -> Netprotohttp3Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_node_fill(s : Netprotohttp3Node, v : Double) -> Netprotohttp3Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_node_min(s : Netprotohttp3Node) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_node_max(s : Netprotohttp3Node) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_node_to_string(s : Netprotohttp3Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_edge_make(size : Int) -> Netprotohttp3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_edge_len(s : Netprotohttp3Edge) -> Int { s.size }

pub fn net_proto_http3_edge_get(s : Netprotohttp3Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_edge_set(s : Netprotohttp3Edge, i : Int, v : Double) -> Netprotohttp3Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_edge_sum(s : Netprotohttp3Edge) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_edge_mean(s : Netprotohttp3Edge) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_edge_scale(s : Netprotohttp3Edge, f : Double) -> Netprotohttp3Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_edge_add(a : Netprotohttp3Edge, b : Netprotohttp3Edge) -> Netprotohttp3Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_edge_copy(s : Netprotohttp3Edge) -> Netprotohttp3Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_edge_fill(s : Netprotohttp3Edge, v : Double) -> Netprotohttp3Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_edge_min(s : Netprotohttp3Edge) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_edge_max(s : Netprotohttp3Edge) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_edge_to_string(s : Netprotohttp3Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_path_make(size : Int) -> Netprotohttp3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_path_len(s : Netprotohttp3Path) -> Int { s.size }

pub fn net_proto_http3_path_get(s : Netprotohttp3Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_path_set(s : Netprotohttp3Path, i : Int, v : Double) -> Netprotohttp3Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_path_sum(s : Netprotohttp3Path) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_path_mean(s : Netprotohttp3Path) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_path_scale(s : Netprotohttp3Path, f : Double) -> Netprotohttp3Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_path_add(a : Netprotohttp3Path, b : Netprotohttp3Path) -> Netprotohttp3Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_path_copy(s : Netprotohttp3Path) -> Netprotohttp3Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_path_fill(s : Netprotohttp3Path, v : Double) -> Netprotohttp3Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_path_min(s : Netprotohttp3Path) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_path_max(s : Netprotohttp3Path) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_path_to_string(s : Netprotohttp3Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_cluster_make(size : Int) -> Netprotohttp3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_cluster_len(s : Netprotohttp3Cluster) -> Int { s.size }

pub fn net_proto_http3_cluster_get(s : Netprotohttp3Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_cluster_set(s : Netprotohttp3Cluster, i : Int, v : Double) -> Netprotohttp3Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cluster_sum(s : Netprotohttp3Cluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_cluster_mean(s : Netprotohttp3Cluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_cluster_scale(s : Netprotohttp3Cluster, f : Double) -> Netprotohttp3Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cluster_add(a : Netprotohttp3Cluster, b : Netprotohttp3Cluster) -> Netprotohttp3Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_cluster_copy(s : Netprotohttp3Cluster) -> Netprotohttp3Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cluster_fill(s : Netprotohttp3Cluster, v : Double) -> Netprotohttp3Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cluster_min(s : Netprotohttp3Cluster) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_cluster_max(s : Netprotohttp3Cluster) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_cluster_to_string(s : Netprotohttp3Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_model_make(size : Int) -> Netprotohttp3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_model_len(s : Netprotohttp3Model) -> Int { s.size }

pub fn net_proto_http3_model_get(s : Netprotohttp3Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_model_set(s : Netprotohttp3Model, i : Int, v : Double) -> Netprotohttp3Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_model_sum(s : Netprotohttp3Model) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_model_mean(s : Netprotohttp3Model) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_model_scale(s : Netprotohttp3Model, f : Double) -> Netprotohttp3Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_model_add(a : Netprotohttp3Model, b : Netprotohttp3Model) -> Netprotohttp3Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_model_copy(s : Netprotohttp3Model) -> Netprotohttp3Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_model_fill(s : Netprotohttp3Model, v : Double) -> Netprotohttp3Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_model_min(s : Netprotohttp3Model) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_model_max(s : Netprotohttp3Model) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_model_to_string(s : Netprotohttp3Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_layer_make(size : Int) -> Netprotohttp3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_layer_len(s : Netprotohttp3Layer) -> Int { s.size }

pub fn net_proto_http3_layer_get(s : Netprotohttp3Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_layer_set(s : Netprotohttp3Layer, i : Int, v : Double) -> Netprotohttp3Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_layer_sum(s : Netprotohttp3Layer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_layer_mean(s : Netprotohttp3Layer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_layer_scale(s : Netprotohttp3Layer, f : Double) -> Netprotohttp3Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_layer_add(a : Netprotohttp3Layer, b : Netprotohttp3Layer) -> Netprotohttp3Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_layer_copy(s : Netprotohttp3Layer) -> Netprotohttp3Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_layer_fill(s : Netprotohttp3Layer, v : Double) -> Netprotohttp3Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_layer_min(s : Netprotohttp3Layer) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_layer_max(s : Netprotohttp3Layer) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_layer_to_string(s : Netprotohttp3Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_buffer_make(size : Int) -> Netprotohttp3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_buffer_len(s : Netprotohttp3Buffer) -> Int { s.size }

pub fn net_proto_http3_buffer_get(s : Netprotohttp3Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_buffer_set(s : Netprotohttp3Buffer, i : Int, v : Double) -> Netprotohttp3Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_buffer_sum(s : Netprotohttp3Buffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_buffer_mean(s : Netprotohttp3Buffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_buffer_scale(s : Netprotohttp3Buffer, f : Double) -> Netprotohttp3Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_buffer_add(a : Netprotohttp3Buffer, b : Netprotohttp3Buffer) -> Netprotohttp3Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_buffer_copy(s : Netprotohttp3Buffer) -> Netprotohttp3Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_buffer_fill(s : Netprotohttp3Buffer, v : Double) -> Netprotohttp3Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_buffer_min(s : Netprotohttp3Buffer) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_buffer_max(s : Netprotohttp3Buffer) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_buffer_to_string(s : Netprotohttp3Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_cursor_make(size : Int) -> Netprotohttp3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_cursor_len(s : Netprotohttp3Cursor) -> Int { s.size }

pub fn net_proto_http3_cursor_get(s : Netprotohttp3Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_cursor_set(s : Netprotohttp3Cursor, i : Int, v : Double) -> Netprotohttp3Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cursor_sum(s : Netprotohttp3Cursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_cursor_mean(s : Netprotohttp3Cursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_cursor_scale(s : Netprotohttp3Cursor, f : Double) -> Netprotohttp3Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cursor_add(a : Netprotohttp3Cursor, b : Netprotohttp3Cursor) -> Netprotohttp3Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_cursor_copy(s : Netprotohttp3Cursor) -> Netprotohttp3Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cursor_fill(s : Netprotohttp3Cursor, v : Double) -> Netprotohttp3Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_cursor_min(s : Netprotohttp3Cursor) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_cursor_max(s : Netprotohttp3Cursor) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_cursor_to_string(s : Netprotohttp3Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_view_make(size : Int) -> Netprotohttp3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_view_len(s : Netprotohttp3View) -> Int { s.size }

pub fn net_proto_http3_view_get(s : Netprotohttp3View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_view_set(s : Netprotohttp3View, i : Int, v : Double) -> Netprotohttp3View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_view_sum(s : Netprotohttp3View) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_view_mean(s : Netprotohttp3View) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_view_scale(s : Netprotohttp3View, f : Double) -> Netprotohttp3View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_view_add(a : Netprotohttp3View, b : Netprotohttp3View) -> Netprotohttp3View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_view_copy(s : Netprotohttp3View) -> Netprotohttp3View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_view_fill(s : Netprotohttp3View, v : Double) -> Netprotohttp3View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_view_min(s : Netprotohttp3View) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_view_max(s : Netprotohttp3View) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_view_to_string(s : Netprotohttp3View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_range_make(size : Int) -> Netprotohttp3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_range_len(s : Netprotohttp3Range) -> Int { s.size }

pub fn net_proto_http3_range_get(s : Netprotohttp3Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_range_set(s : Netprotohttp3Range, i : Int, v : Double) -> Netprotohttp3Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_range_sum(s : Netprotohttp3Range) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_range_mean(s : Netprotohttp3Range) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_range_scale(s : Netprotohttp3Range, f : Double) -> Netprotohttp3Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_range_add(a : Netprotohttp3Range, b : Netprotohttp3Range) -> Netprotohttp3Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_range_copy(s : Netprotohttp3Range) -> Netprotohttp3Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_range_fill(s : Netprotohttp3Range, v : Double) -> Netprotohttp3Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_range_min(s : Netprotohttp3Range) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_range_max(s : Netprotohttp3Range) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_range_to_string(s : Netprotohttp3Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http3_slice_make(size : Int) -> Netprotohttp3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http3_slice_len(s : Netprotohttp3Slice) -> Int { s.size }

pub fn net_proto_http3_slice_get(s : Netprotohttp3Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http3_slice_set(s : Netprotohttp3Slice, i : Int, v : Double) -> Netprotohttp3Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_http3_slice_sum(s : Netprotohttp3Slice) -> Double { @_common.sum(s.data) }

pub fn net_proto_http3_slice_mean(s : Netprotohttp3Slice) -> Double { @_common.mean(s.data) }

pub fn net_proto_http3_slice_scale(s : Netprotohttp3Slice, f : Double) -> Netprotohttp3Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_slice_add(a : Netprotohttp3Slice, b : Netprotohttp3Slice) -> Netprotohttp3Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http3_slice_copy(s : Netprotohttp3Slice) -> Netprotohttp3Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_slice_fill(s : Netprotohttp3Slice, v : Double) -> Netprotohttp3Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http3_slice_min(s : Netprotohttp3Slice) -> Double { @_common.min(s.data) }

pub fn net_proto_http3_slice_max(s : Netprotohttp3Slice) -> Double { @_common.max(s.data) }

pub fn net_proto_http3_slice_to_string(s : Netprotohttp3Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

