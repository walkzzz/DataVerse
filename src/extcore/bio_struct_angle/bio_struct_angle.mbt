///===
/// extcore/bio_struct_angle

pub(all) struct BiostructanglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_angle_make_point(x : Double, y : Double) -> BiostructanglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_angle_make_point3(x : Double, y : Double, z : Double) -> BiostructanglePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructanglePoint::x(self : BiostructanglePoint) -> Double { self.x }

pub fn BiostructanglePoint::y(self : BiostructanglePoint) -> Double { self.y }

pub fn BiostructanglePoint::z(self : BiostructanglePoint) -> Double { self.z }

pub fn BiostructanglePoint::label(self : BiostructanglePoint) -> Int { self.label }

pub fn BiostructanglePoint::dist(self : BiostructanglePoint, other : BiostructanglePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructanglePoint::add(self : BiostructanglePoint, other : BiostructanglePoint) -> BiostructanglePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructanglePoint::sub(self : BiostructanglePoint, other : BiostructanglePoint) -> BiostructanglePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructanglePoint::scale(self : BiostructanglePoint, s : Double) -> BiostructanglePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructanglePoint::dot(self : BiostructanglePoint, other : BiostructanglePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructanglePoint::cross(self : BiostructanglePoint, other : BiostructanglePoint) -> BiostructanglePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructanglePoint::norm(self : BiostructanglePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructanglePoint::normalize(self : BiostructanglePoint) -> BiostructanglePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructanglePoint::negate(self : BiostructanglePoint) -> BiostructanglePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructanglePoint::mid(self : BiostructanglePoint, other : BiostructanglePoint) -> BiostructanglePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructanglePoint::lerp(self : BiostructanglePoint, other : BiostructanglePoint, t : Double) -> BiostructanglePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructanglePoint::to_string(self : BiostructanglePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_angle_make_series(vals : Array[Double], name : String) -> BiostructangleSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructangleSeries::len(self : BiostructangleSeries) -> Int { self.vals.length() }

pub fn BiostructangleSeries::sum(self : BiostructangleSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructangleSeries::mean(self : BiostructangleSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructangleSeries::min(self : BiostructangleSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructangleSeries::max(self : BiostructangleSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructangleSeries::range(self : BiostructangleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructangleSeries::variance(self : BiostructangleSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructangleSeries::std(self : BiostructangleSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructangleSeries::median(self : BiostructangleSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructangleSeries::scale(self : BiostructangleSeries, f : Double) -> BiostructangleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructangleSeries::add(self : BiostructangleSeries, other : BiostructangleSeries) -> BiostructangleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructangleSeries::sub(self : BiostructangleSeries, other : BiostructangleSeries) -> BiostructangleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructangleSeries::normalize(self : BiostructangleSeries) -> BiostructangleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructangleSeries::cumsum(self : BiostructangleSeries) -> BiostructangleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructangleSeries::to_string(self : BiostructangleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_angle_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructangleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_angle_matrix_identity(n : Int) -> BiostructangleMatrix {
  let m = bio_struct_angle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructangleMatrix::get(self : BiostructangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructangleMatrix::transpose(self : BiostructangleMatrix) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructangleMatrix::add(self : BiostructangleMatrix, other : BiostructangleMatrix) -> BiostructangleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_angle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructangleMatrix::scale(self : BiostructangleMatrix, s : Double) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructangleMatrix::multiply(self : BiostructangleMatrix, other : BiostructangleMatrix) -> BiostructangleMatrix {
  if self.cols != other.rows { return bio_struct_angle_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_angle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructangleMatrix::trace(self : BiostructangleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructangleMatrix::det(self : BiostructangleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructangleMatrix::norm(self : BiostructangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructangleMatrix::to_string(self : BiostructangleMatrix) -> String {
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

pub(all) struct BiostructangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_angle_make_vector(comps : Array[Double]) -> BiostructangleVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_angle_vector_zero(dim : Int) -> BiostructangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructangleVector::add(self : BiostructangleVector, other : BiostructangleVector) -> BiostructangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructangleVector::sub(self : BiostructangleVector, other : BiostructangleVector) -> BiostructangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructangleVector::scale(self : BiostructangleVector, s : Double) -> BiostructangleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructangleVector::dot(self : BiostructangleVector, other : BiostructangleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructangleVector::norm(self : BiostructangleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructangleVector::normalize(self : BiostructangleVector) -> BiostructangleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructangleVector::dist(self : BiostructangleVector, other : BiostructangleVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructangleVector::to_string(self : BiostructangleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_angle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_angle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_angle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_angle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_angle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_angle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_angle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_angle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_angle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_angle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_angle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_angle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_angle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_angle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_angle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_angle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_angle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_angle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_angle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_angle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_angle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_angle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_angle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_angle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_angle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_angle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_angle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_angle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_angle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_frame_make(size : Int) -> BiostructangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_frame_len(s : BiostructangleFrame) -> Int { s.size }

pub fn bio_struct_angle_frame_get(s : BiostructangleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_frame_set(s : BiostructangleFrame, i : Int, v : Double) -> BiostructangleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_sum(s : BiostructangleFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_frame_mean(s : BiostructangleFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_frame_scale(s : BiostructangleFrame, f : Double) -> BiostructangleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_add(a : BiostructangleFrame, b : BiostructangleFrame) -> BiostructangleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_frame_copy(s : BiostructangleFrame) -> BiostructangleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_fill(s : BiostructangleFrame, v : Double) -> BiostructangleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_min(s : BiostructangleFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_frame_max(s : BiostructangleFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_frame_to_string(s : BiostructangleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_table_make(size : Int) -> BiostructangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_table_len(s : BiostructangleTable) -> Int { s.size }

pub fn bio_struct_angle_table_get(s : BiostructangleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_table_set(s : BiostructangleTable, i : Int, v : Double) -> BiostructangleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_sum(s : BiostructangleTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_table_mean(s : BiostructangleTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_table_scale(s : BiostructangleTable, f : Double) -> BiostructangleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_add(a : BiostructangleTable, b : BiostructangleTable) -> BiostructangleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_table_copy(s : BiostructangleTable) -> BiostructangleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_fill(s : BiostructangleTable, v : Double) -> BiostructangleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_min(s : BiostructangleTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_table_max(s : BiostructangleTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_table_to_string(s : BiostructangleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_graphn_make(size : Int) -> BiostructangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_graphn_len(s : BiostructangleGraphN) -> Int { s.size }

pub fn bio_struct_angle_graphn_get(s : BiostructangleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_graphn_set(s : BiostructangleGraphN, i : Int, v : Double) -> BiostructangleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_sum(s : BiostructangleGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_graphn_mean(s : BiostructangleGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_graphn_scale(s : BiostructangleGraphN, f : Double) -> BiostructangleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_add(a : BiostructangleGraphN, b : BiostructangleGraphN) -> BiostructangleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_graphn_copy(s : BiostructangleGraphN) -> BiostructangleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_fill(s : BiostructangleGraphN, v : Double) -> BiostructangleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_min(s : BiostructangleGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_graphn_max(s : BiostructangleGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_graphn_to_string(s : BiostructangleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_node_make(size : Int) -> BiostructangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_node_len(s : BiostructangleNode) -> Int { s.size }

pub fn bio_struct_angle_node_get(s : BiostructangleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_node_set(s : BiostructangleNode, i : Int, v : Double) -> BiostructangleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_sum(s : BiostructangleNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_node_mean(s : BiostructangleNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_node_scale(s : BiostructangleNode, f : Double) -> BiostructangleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_add(a : BiostructangleNode, b : BiostructangleNode) -> BiostructangleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_node_copy(s : BiostructangleNode) -> BiostructangleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_fill(s : BiostructangleNode, v : Double) -> BiostructangleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_min(s : BiostructangleNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_node_max(s : BiostructangleNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_node_to_string(s : BiostructangleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_edge_make(size : Int) -> BiostructangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_edge_len(s : BiostructangleEdge) -> Int { s.size }

pub fn bio_struct_angle_edge_get(s : BiostructangleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_edge_set(s : BiostructangleEdge, i : Int, v : Double) -> BiostructangleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_sum(s : BiostructangleEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_edge_mean(s : BiostructangleEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_edge_scale(s : BiostructangleEdge, f : Double) -> BiostructangleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_add(a : BiostructangleEdge, b : BiostructangleEdge) -> BiostructangleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_edge_copy(s : BiostructangleEdge) -> BiostructangleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_fill(s : BiostructangleEdge, v : Double) -> BiostructangleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_min(s : BiostructangleEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_edge_max(s : BiostructangleEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_edge_to_string(s : BiostructangleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructanglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_path_make(size : Int) -> BiostructanglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_path_len(s : BiostructanglePath) -> Int { s.size }

pub fn bio_struct_angle_path_get(s : BiostructanglePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_path_set(s : BiostructanglePath, i : Int, v : Double) -> BiostructanglePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_sum(s : BiostructanglePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_path_mean(s : BiostructanglePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_path_scale(s : BiostructanglePath, f : Double) -> BiostructanglePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_add(a : BiostructanglePath, b : BiostructanglePath) -> BiostructanglePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_path_copy(s : BiostructanglePath) -> BiostructanglePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_fill(s : BiostructanglePath, v : Double) -> BiostructanglePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_min(s : BiostructanglePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_path_max(s : BiostructanglePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_path_to_string(s : BiostructanglePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_cluster_make(size : Int) -> BiostructangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_cluster_len(s : BiostructangleCluster) -> Int { s.size }

pub fn bio_struct_angle_cluster_get(s : BiostructangleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_cluster_set(s : BiostructangleCluster, i : Int, v : Double) -> BiostructangleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_sum(s : BiostructangleCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_cluster_mean(s : BiostructangleCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_cluster_scale(s : BiostructangleCluster, f : Double) -> BiostructangleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_add(a : BiostructangleCluster, b : BiostructangleCluster) -> BiostructangleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_cluster_copy(s : BiostructangleCluster) -> BiostructangleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_fill(s : BiostructangleCluster, v : Double) -> BiostructangleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_min(s : BiostructangleCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_cluster_max(s : BiostructangleCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_cluster_to_string(s : BiostructangleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_model_make(size : Int) -> BiostructangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_model_len(s : BiostructangleModel) -> Int { s.size }

pub fn bio_struct_angle_model_get(s : BiostructangleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_model_set(s : BiostructangleModel, i : Int, v : Double) -> BiostructangleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_sum(s : BiostructangleModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_model_mean(s : BiostructangleModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_model_scale(s : BiostructangleModel, f : Double) -> BiostructangleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_add(a : BiostructangleModel, b : BiostructangleModel) -> BiostructangleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_model_copy(s : BiostructangleModel) -> BiostructangleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_fill(s : BiostructangleModel, v : Double) -> BiostructangleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_min(s : BiostructangleModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_model_max(s : BiostructangleModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_model_to_string(s : BiostructangleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_layer_make(size : Int) -> BiostructangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_layer_len(s : BiostructangleLayer) -> Int { s.size }

pub fn bio_struct_angle_layer_get(s : BiostructangleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_layer_set(s : BiostructangleLayer, i : Int, v : Double) -> BiostructangleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_sum(s : BiostructangleLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_layer_mean(s : BiostructangleLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_layer_scale(s : BiostructangleLayer, f : Double) -> BiostructangleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_add(a : BiostructangleLayer, b : BiostructangleLayer) -> BiostructangleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_layer_copy(s : BiostructangleLayer) -> BiostructangleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_fill(s : BiostructangleLayer, v : Double) -> BiostructangleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_min(s : BiostructangleLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_layer_max(s : BiostructangleLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_layer_to_string(s : BiostructangleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_buffer_make(size : Int) -> BiostructangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_buffer_len(s : BiostructangleBuffer) -> Int { s.size }

pub fn bio_struct_angle_buffer_get(s : BiostructangleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_buffer_set(s : BiostructangleBuffer, i : Int, v : Double) -> BiostructangleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_sum(s : BiostructangleBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_buffer_mean(s : BiostructangleBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_buffer_scale(s : BiostructangleBuffer, f : Double) -> BiostructangleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_add(a : BiostructangleBuffer, b : BiostructangleBuffer) -> BiostructangleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_buffer_copy(s : BiostructangleBuffer) -> BiostructangleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_fill(s : BiostructangleBuffer, v : Double) -> BiostructangleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_min(s : BiostructangleBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_buffer_max(s : BiostructangleBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_buffer_to_string(s : BiostructangleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_cursor_make(size : Int) -> BiostructangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_cursor_len(s : BiostructangleCursor) -> Int { s.size }

pub fn bio_struct_angle_cursor_get(s : BiostructangleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_cursor_set(s : BiostructangleCursor, i : Int, v : Double) -> BiostructangleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_sum(s : BiostructangleCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_cursor_mean(s : BiostructangleCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_cursor_scale(s : BiostructangleCursor, f : Double) -> BiostructangleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_add(a : BiostructangleCursor, b : BiostructangleCursor) -> BiostructangleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_cursor_copy(s : BiostructangleCursor) -> BiostructangleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_fill(s : BiostructangleCursor, v : Double) -> BiostructangleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_min(s : BiostructangleCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_cursor_max(s : BiostructangleCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_cursor_to_string(s : BiostructangleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_view_make(size : Int) -> BiostructangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_view_len(s : BiostructangleView) -> Int { s.size }

pub fn bio_struct_angle_view_get(s : BiostructangleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_view_set(s : BiostructangleView, i : Int, v : Double) -> BiostructangleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_sum(s : BiostructangleView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_view_mean(s : BiostructangleView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_view_scale(s : BiostructangleView, f : Double) -> BiostructangleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_add(a : BiostructangleView, b : BiostructangleView) -> BiostructangleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_view_copy(s : BiostructangleView) -> BiostructangleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_fill(s : BiostructangleView, v : Double) -> BiostructangleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_min(s : BiostructangleView) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_view_max(s : BiostructangleView) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_view_to_string(s : BiostructangleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_range_make(size : Int) -> BiostructangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_range_len(s : BiostructangleRange) -> Int { s.size }

pub fn bio_struct_angle_range_get(s : BiostructangleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_range_set(s : BiostructangleRange, i : Int, v : Double) -> BiostructangleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_sum(s : BiostructangleRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_range_mean(s : BiostructangleRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_range_scale(s : BiostructangleRange, f : Double) -> BiostructangleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_add(a : BiostructangleRange, b : BiostructangleRange) -> BiostructangleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_range_copy(s : BiostructangleRange) -> BiostructangleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_fill(s : BiostructangleRange, v : Double) -> BiostructangleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_min(s : BiostructangleRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_range_max(s : BiostructangleRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_range_to_string(s : BiostructangleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_slice_make(size : Int) -> BiostructangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_slice_len(s : BiostructangleSlice) -> Int { s.size }

pub fn bio_struct_angle_slice_get(s : BiostructangleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_slice_set(s : BiostructangleSlice, i : Int, v : Double) -> BiostructangleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_sum(s : BiostructangleSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_slice_mean(s : BiostructangleSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_slice_scale(s : BiostructangleSlice, f : Double) -> BiostructangleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_add(a : BiostructangleSlice, b : BiostructangleSlice) -> BiostructangleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_slice_copy(s : BiostructangleSlice) -> BiostructangleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_fill(s : BiostructangleSlice, v : Double) -> BiostructangleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_min(s : BiostructangleSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_slice_max(s : BiostructangleSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_slice_to_string(s : BiostructangleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

