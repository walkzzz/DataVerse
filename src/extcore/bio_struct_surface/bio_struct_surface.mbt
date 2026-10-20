///===
/// extcore/bio_struct_surface

pub(all) struct BiostructsurfacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_surface_make_point(x : Double, y : Double) -> BiostructsurfacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_surface_make_point3(x : Double, y : Double, z : Double) -> BiostructsurfacePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructsurfacePoint::x(self : BiostructsurfacePoint) -> Double { self.x }

pub fn BiostructsurfacePoint::y(self : BiostructsurfacePoint) -> Double { self.y }

pub fn BiostructsurfacePoint::z(self : BiostructsurfacePoint) -> Double { self.z }

pub fn BiostructsurfacePoint::label(self : BiostructsurfacePoint) -> Int { self.label }

pub fn BiostructsurfacePoint::dist(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructsurfacePoint::add(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructsurfacePoint::sub(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructsurfacePoint::scale(self : BiostructsurfacePoint, s : Double) -> BiostructsurfacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructsurfacePoint::dot(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructsurfacePoint::cross(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructsurfacePoint::norm(self : BiostructsurfacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructsurfacePoint::normalize(self : BiostructsurfacePoint) -> BiostructsurfacePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsurfacePoint::negate(self : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructsurfacePoint::mid(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructsurfacePoint::lerp(self : BiostructsurfacePoint, other : BiostructsurfacePoint, t : Double) -> BiostructsurfacePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructsurfacePoint::to_string(self : BiostructsurfacePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructsurfaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_surface_make_series(vals : Array[Double], name : String) -> BiostructsurfaceSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructsurfaceSeries::len(self : BiostructsurfaceSeries) -> Int { self.vals.length() }

pub fn BiostructsurfaceSeries::sum(self : BiostructsurfaceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructsurfaceSeries::mean(self : BiostructsurfaceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructsurfaceSeries::min(self : BiostructsurfaceSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructsurfaceSeries::max(self : BiostructsurfaceSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructsurfaceSeries::range(self : BiostructsurfaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructsurfaceSeries::variance(self : BiostructsurfaceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructsurfaceSeries::std(self : BiostructsurfaceSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructsurfaceSeries::median(self : BiostructsurfaceSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructsurfaceSeries::scale(self : BiostructsurfaceSeries, f : Double) -> BiostructsurfaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::add(self : BiostructsurfaceSeries, other : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::sub(self : BiostructsurfaceSeries, other : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::normalize(self : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructsurfaceSeries::cumsum(self : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructsurfaceSeries::to_string(self : BiostructsurfaceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsurfaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_surface_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsurfaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_surface_matrix_identity(n : Int) -> BiostructsurfaceMatrix {
  let m = bio_struct_surface_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructsurfaceMatrix::get(self : BiostructsurfaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructsurfaceMatrix::transpose(self : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructsurfaceMatrix::add(self : BiostructsurfaceMatrix, other : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_surface_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructsurfaceMatrix::scale(self : BiostructsurfaceMatrix, s : Double) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructsurfaceMatrix::multiply(self : BiostructsurfaceMatrix, other : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if self.cols != other.rows { return bio_struct_surface_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_surface_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructsurfaceMatrix::trace(self : BiostructsurfaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructsurfaceMatrix::det(self : BiostructsurfaceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructsurfaceMatrix::norm(self : BiostructsurfaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructsurfaceMatrix::to_string(self : BiostructsurfaceMatrix) -> String {
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

pub(all) struct BiostructsurfaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_surface_make_vector(comps : Array[Double]) -> BiostructsurfaceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_surface_vector_zero(dim : Int) -> BiostructsurfaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructsurfaceVector::add(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsurfaceVector::sub(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsurfaceVector::scale(self : BiostructsurfaceVector, s : Double) -> BiostructsurfaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructsurfaceVector::dot(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructsurfaceVector::norm(self : BiostructsurfaceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructsurfaceVector::normalize(self : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsurfaceVector::dist(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructsurfaceVector::to_string(self : BiostructsurfaceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_surface_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_surface_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_surface_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_surface_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_surface_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_surface_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_surface_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_surface_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_surface_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_surface_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_surface_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_surface_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_surface_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_surface_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_surface_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_surface_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_surface_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_surface_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_surface_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_surface_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_surface_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_surface_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_surface_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_surface_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_surface_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_surface_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_surface_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_surface_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_surface_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsurfaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_frame_make(size : Int) -> BiostructsurfaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_frame_len(s : BiostructsurfaceFrame) -> Int { s.size }

pub fn bio_struct_surface_frame_get(s : BiostructsurfaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_frame_set(s : BiostructsurfaceFrame, i : Int, v : Double) -> BiostructsurfaceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_frame_sum(s : BiostructsurfaceFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_frame_mean(s : BiostructsurfaceFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_frame_scale(s : BiostructsurfaceFrame, f : Double) -> BiostructsurfaceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_frame_add(a : BiostructsurfaceFrame, b : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_frame_copy(s : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_frame_fill(s : BiostructsurfaceFrame, v : Double) -> BiostructsurfaceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_frame_min(s : BiostructsurfaceFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_frame_max(s : BiostructsurfaceFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_frame_to_string(s : BiostructsurfaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_table_make(size : Int) -> BiostructsurfaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_table_len(s : BiostructsurfaceTable) -> Int { s.size }

pub fn bio_struct_surface_table_get(s : BiostructsurfaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_table_set(s : BiostructsurfaceTable, i : Int, v : Double) -> BiostructsurfaceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_table_sum(s : BiostructsurfaceTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_table_mean(s : BiostructsurfaceTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_table_scale(s : BiostructsurfaceTable, f : Double) -> BiostructsurfaceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_table_add(a : BiostructsurfaceTable, b : BiostructsurfaceTable) -> BiostructsurfaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_table_copy(s : BiostructsurfaceTable) -> BiostructsurfaceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_table_fill(s : BiostructsurfaceTable, v : Double) -> BiostructsurfaceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_table_min(s : BiostructsurfaceTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_table_max(s : BiostructsurfaceTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_table_to_string(s : BiostructsurfaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_graphn_make(size : Int) -> BiostructsurfaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_graphn_len(s : BiostructsurfaceGraphN) -> Int { s.size }

pub fn bio_struct_surface_graphn_get(s : BiostructsurfaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_graphn_set(s : BiostructsurfaceGraphN, i : Int, v : Double) -> BiostructsurfaceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_graphn_sum(s : BiostructsurfaceGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_graphn_mean(s : BiostructsurfaceGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_graphn_scale(s : BiostructsurfaceGraphN, f : Double) -> BiostructsurfaceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_graphn_add(a : BiostructsurfaceGraphN, b : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_graphn_copy(s : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_graphn_fill(s : BiostructsurfaceGraphN, v : Double) -> BiostructsurfaceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_graphn_min(s : BiostructsurfaceGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_graphn_max(s : BiostructsurfaceGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_graphn_to_string(s : BiostructsurfaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_node_make(size : Int) -> BiostructsurfaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_node_len(s : BiostructsurfaceNode) -> Int { s.size }

pub fn bio_struct_surface_node_get(s : BiostructsurfaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_node_set(s : BiostructsurfaceNode, i : Int, v : Double) -> BiostructsurfaceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_node_sum(s : BiostructsurfaceNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_node_mean(s : BiostructsurfaceNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_node_scale(s : BiostructsurfaceNode, f : Double) -> BiostructsurfaceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_node_add(a : BiostructsurfaceNode, b : BiostructsurfaceNode) -> BiostructsurfaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_node_copy(s : BiostructsurfaceNode) -> BiostructsurfaceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_node_fill(s : BiostructsurfaceNode, v : Double) -> BiostructsurfaceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_node_min(s : BiostructsurfaceNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_node_max(s : BiostructsurfaceNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_node_to_string(s : BiostructsurfaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_edge_make(size : Int) -> BiostructsurfaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_edge_len(s : BiostructsurfaceEdge) -> Int { s.size }

pub fn bio_struct_surface_edge_get(s : BiostructsurfaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_edge_set(s : BiostructsurfaceEdge, i : Int, v : Double) -> BiostructsurfaceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_edge_sum(s : BiostructsurfaceEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_edge_mean(s : BiostructsurfaceEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_edge_scale(s : BiostructsurfaceEdge, f : Double) -> BiostructsurfaceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_edge_add(a : BiostructsurfaceEdge, b : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_edge_copy(s : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_edge_fill(s : BiostructsurfaceEdge, v : Double) -> BiostructsurfaceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_edge_min(s : BiostructsurfaceEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_edge_max(s : BiostructsurfaceEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_edge_to_string(s : BiostructsurfaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_path_make(size : Int) -> BiostructsurfacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_path_len(s : BiostructsurfacePath) -> Int { s.size }

pub fn bio_struct_surface_path_get(s : BiostructsurfacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_path_set(s : BiostructsurfacePath, i : Int, v : Double) -> BiostructsurfacePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_path_sum(s : BiostructsurfacePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_path_mean(s : BiostructsurfacePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_path_scale(s : BiostructsurfacePath, f : Double) -> BiostructsurfacePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_path_add(a : BiostructsurfacePath, b : BiostructsurfacePath) -> BiostructsurfacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_path_copy(s : BiostructsurfacePath) -> BiostructsurfacePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_path_fill(s : BiostructsurfacePath, v : Double) -> BiostructsurfacePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_path_min(s : BiostructsurfacePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_path_max(s : BiostructsurfacePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_path_to_string(s : BiostructsurfacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cluster_make(size : Int) -> BiostructsurfaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_cluster_len(s : BiostructsurfaceCluster) -> Int { s.size }

pub fn bio_struct_surface_cluster_get(s : BiostructsurfaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_cluster_set(s : BiostructsurfaceCluster, i : Int, v : Double) -> BiostructsurfaceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cluster_sum(s : BiostructsurfaceCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_cluster_mean(s : BiostructsurfaceCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_cluster_scale(s : BiostructsurfaceCluster, f : Double) -> BiostructsurfaceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cluster_add(a : BiostructsurfaceCluster, b : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_cluster_copy(s : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cluster_fill(s : BiostructsurfaceCluster, v : Double) -> BiostructsurfaceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cluster_min(s : BiostructsurfaceCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_cluster_max(s : BiostructsurfaceCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_cluster_to_string(s : BiostructsurfaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_model_make(size : Int) -> BiostructsurfaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_model_len(s : BiostructsurfaceModel) -> Int { s.size }

pub fn bio_struct_surface_model_get(s : BiostructsurfaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_model_set(s : BiostructsurfaceModel, i : Int, v : Double) -> BiostructsurfaceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_model_sum(s : BiostructsurfaceModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_model_mean(s : BiostructsurfaceModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_model_scale(s : BiostructsurfaceModel, f : Double) -> BiostructsurfaceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_model_add(a : BiostructsurfaceModel, b : BiostructsurfaceModel) -> BiostructsurfaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_model_copy(s : BiostructsurfaceModel) -> BiostructsurfaceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_model_fill(s : BiostructsurfaceModel, v : Double) -> BiostructsurfaceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_model_min(s : BiostructsurfaceModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_model_max(s : BiostructsurfaceModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_model_to_string(s : BiostructsurfaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_layer_make(size : Int) -> BiostructsurfaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_layer_len(s : BiostructsurfaceLayer) -> Int { s.size }

pub fn bio_struct_surface_layer_get(s : BiostructsurfaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_layer_set(s : BiostructsurfaceLayer, i : Int, v : Double) -> BiostructsurfaceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_layer_sum(s : BiostructsurfaceLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_layer_mean(s : BiostructsurfaceLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_layer_scale(s : BiostructsurfaceLayer, f : Double) -> BiostructsurfaceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_layer_add(a : BiostructsurfaceLayer, b : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_layer_copy(s : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_layer_fill(s : BiostructsurfaceLayer, v : Double) -> BiostructsurfaceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_layer_min(s : BiostructsurfaceLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_layer_max(s : BiostructsurfaceLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_layer_to_string(s : BiostructsurfaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_buffer_make(size : Int) -> BiostructsurfaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_buffer_len(s : BiostructsurfaceBuffer) -> Int { s.size }

pub fn bio_struct_surface_buffer_get(s : BiostructsurfaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_buffer_set(s : BiostructsurfaceBuffer, i : Int, v : Double) -> BiostructsurfaceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_buffer_sum(s : BiostructsurfaceBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_buffer_mean(s : BiostructsurfaceBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_buffer_scale(s : BiostructsurfaceBuffer, f : Double) -> BiostructsurfaceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_buffer_add(a : BiostructsurfaceBuffer, b : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_buffer_copy(s : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_buffer_fill(s : BiostructsurfaceBuffer, v : Double) -> BiostructsurfaceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_buffer_min(s : BiostructsurfaceBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_buffer_max(s : BiostructsurfaceBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_buffer_to_string(s : BiostructsurfaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cursor_make(size : Int) -> BiostructsurfaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_cursor_len(s : BiostructsurfaceCursor) -> Int { s.size }

pub fn bio_struct_surface_cursor_get(s : BiostructsurfaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_cursor_set(s : BiostructsurfaceCursor, i : Int, v : Double) -> BiostructsurfaceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cursor_sum(s : BiostructsurfaceCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_cursor_mean(s : BiostructsurfaceCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_cursor_scale(s : BiostructsurfaceCursor, f : Double) -> BiostructsurfaceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cursor_add(a : BiostructsurfaceCursor, b : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_cursor_copy(s : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cursor_fill(s : BiostructsurfaceCursor, v : Double) -> BiostructsurfaceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_cursor_min(s : BiostructsurfaceCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_cursor_max(s : BiostructsurfaceCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_cursor_to_string(s : BiostructsurfaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_view_make(size : Int) -> BiostructsurfaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_view_len(s : BiostructsurfaceView) -> Int { s.size }

pub fn bio_struct_surface_view_get(s : BiostructsurfaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_view_set(s : BiostructsurfaceView, i : Int, v : Double) -> BiostructsurfaceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_view_sum(s : BiostructsurfaceView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_view_mean(s : BiostructsurfaceView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_view_scale(s : BiostructsurfaceView, f : Double) -> BiostructsurfaceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_view_add(a : BiostructsurfaceView, b : BiostructsurfaceView) -> BiostructsurfaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_view_copy(s : BiostructsurfaceView) -> BiostructsurfaceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_view_fill(s : BiostructsurfaceView, v : Double) -> BiostructsurfaceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_view_min(s : BiostructsurfaceView) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_view_max(s : BiostructsurfaceView) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_view_to_string(s : BiostructsurfaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_range_make(size : Int) -> BiostructsurfaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_range_len(s : BiostructsurfaceRange) -> Int { s.size }

pub fn bio_struct_surface_range_get(s : BiostructsurfaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_range_set(s : BiostructsurfaceRange, i : Int, v : Double) -> BiostructsurfaceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_range_sum(s : BiostructsurfaceRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_range_mean(s : BiostructsurfaceRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_range_scale(s : BiostructsurfaceRange, f : Double) -> BiostructsurfaceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_range_add(a : BiostructsurfaceRange, b : BiostructsurfaceRange) -> BiostructsurfaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_range_copy(s : BiostructsurfaceRange) -> BiostructsurfaceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_range_fill(s : BiostructsurfaceRange, v : Double) -> BiostructsurfaceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_range_min(s : BiostructsurfaceRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_range_max(s : BiostructsurfaceRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_range_to_string(s : BiostructsurfaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_slice_make(size : Int) -> BiostructsurfaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_slice_len(s : BiostructsurfaceSlice) -> Int { s.size }

pub fn bio_struct_surface_slice_get(s : BiostructsurfaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_slice_set(s : BiostructsurfaceSlice, i : Int, v : Double) -> BiostructsurfaceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_slice_sum(s : BiostructsurfaceSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_slice_mean(s : BiostructsurfaceSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_slice_scale(s : BiostructsurfaceSlice, f : Double) -> BiostructsurfaceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_slice_add(a : BiostructsurfaceSlice, b : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_surface_slice_copy(s : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_slice_fill(s : BiostructsurfaceSlice, v : Double) -> BiostructsurfaceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_surface_slice_min(s : BiostructsurfaceSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_slice_max(s : BiostructsurfaceSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_slice_to_string(s : BiostructsurfaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

