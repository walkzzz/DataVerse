///===
/// extcore/bio_struct_volume

pub(all) struct BiostructvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_volume_make_point(x : Double, y : Double) -> BiostructvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_volume_make_point3(x : Double, y : Double, z : Double) -> BiostructvolumePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructvolumePoint::x(self : BiostructvolumePoint) -> Double { self.x }

pub fn BiostructvolumePoint::y(self : BiostructvolumePoint) -> Double { self.y }

pub fn BiostructvolumePoint::z(self : BiostructvolumePoint) -> Double { self.z }

pub fn BiostructvolumePoint::label(self : BiostructvolumePoint) -> Int { self.label }

pub fn BiostructvolumePoint::dist(self : BiostructvolumePoint, other : BiostructvolumePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructvolumePoint::add(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructvolumePoint::sub(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructvolumePoint::scale(self : BiostructvolumePoint, s : Double) -> BiostructvolumePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructvolumePoint::dot(self : BiostructvolumePoint, other : BiostructvolumePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructvolumePoint::cross(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructvolumePoint::norm(self : BiostructvolumePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructvolumePoint::normalize(self : BiostructvolumePoint) -> BiostructvolumePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructvolumePoint::negate(self : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructvolumePoint::mid(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructvolumePoint::lerp(self : BiostructvolumePoint, other : BiostructvolumePoint, t : Double) -> BiostructvolumePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructvolumePoint::to_string(self : BiostructvolumePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_volume_make_series(vals : Array[Double], name : String) -> BiostructvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructvolumeSeries::len(self : BiostructvolumeSeries) -> Int { self.vals.length() }

pub fn BiostructvolumeSeries::sum(self : BiostructvolumeSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructvolumeSeries::mean(self : BiostructvolumeSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructvolumeSeries::min(self : BiostructvolumeSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructvolumeSeries::max(self : BiostructvolumeSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructvolumeSeries::range(self : BiostructvolumeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructvolumeSeries::variance(self : BiostructvolumeSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructvolumeSeries::std(self : BiostructvolumeSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructvolumeSeries::median(self : BiostructvolumeSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructvolumeSeries::scale(self : BiostructvolumeSeries, f : Double) -> BiostructvolumeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::add(self : BiostructvolumeSeries, other : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::sub(self : BiostructvolumeSeries, other : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::normalize(self : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructvolumeSeries::cumsum(self : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructvolumeSeries::to_string(self : BiostructvolumeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_volume_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_volume_matrix_identity(n : Int) -> BiostructvolumeMatrix {
  let m = bio_struct_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructvolumeMatrix::get(self : BiostructvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructvolumeMatrix::transpose(self : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructvolumeMatrix::add(self : BiostructvolumeMatrix, other : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructvolumeMatrix::scale(self : BiostructvolumeMatrix, s : Double) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructvolumeMatrix::multiply(self : BiostructvolumeMatrix, other : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if self.cols != other.rows { return bio_struct_volume_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_volume_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructvolumeMatrix::trace(self : BiostructvolumeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructvolumeMatrix::det(self : BiostructvolumeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructvolumeMatrix::norm(self : BiostructvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructvolumeMatrix::to_string(self : BiostructvolumeMatrix) -> String {
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

pub(all) struct BiostructvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_volume_make_vector(comps : Array[Double]) -> BiostructvolumeVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_volume_vector_zero(dim : Int) -> BiostructvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructvolumeVector::add(self : BiostructvolumeVector, other : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructvolumeVector::sub(self : BiostructvolumeVector, other : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructvolumeVector::scale(self : BiostructvolumeVector, s : Double) -> BiostructvolumeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructvolumeVector::dot(self : BiostructvolumeVector, other : BiostructvolumeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructvolumeVector::norm(self : BiostructvolumeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructvolumeVector::normalize(self : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructvolumeVector::dist(self : BiostructvolumeVector, other : BiostructvolumeVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructvolumeVector::to_string(self : BiostructvolumeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_volume_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_volume_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_volume_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_volume_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_volume_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_volume_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_volume_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_volume_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_volume_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_volume_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_volume_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_volume_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_volume_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_volume_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_volume_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_volume_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_volume_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_volume_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_volume_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_volume_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_volume_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_volume_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_volume_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_volume_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_volume_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_volume_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_volume_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_volume_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_volume_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_frame_make(size : Int) -> BiostructvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_frame_len(s : BiostructvolumeFrame) -> Int { s.size }

pub fn bio_struct_volume_frame_get(s : BiostructvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_frame_set(s : BiostructvolumeFrame, i : Int, v : Double) -> BiostructvolumeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_frame_sum(s : BiostructvolumeFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_frame_mean(s : BiostructvolumeFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_frame_scale(s : BiostructvolumeFrame, f : Double) -> BiostructvolumeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_frame_add(a : BiostructvolumeFrame, b : BiostructvolumeFrame) -> BiostructvolumeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_frame_copy(s : BiostructvolumeFrame) -> BiostructvolumeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_frame_fill(s : BiostructvolumeFrame, v : Double) -> BiostructvolumeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_frame_min(s : BiostructvolumeFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_frame_max(s : BiostructvolumeFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_frame_to_string(s : BiostructvolumeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_table_make(size : Int) -> BiostructvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_table_len(s : BiostructvolumeTable) -> Int { s.size }

pub fn bio_struct_volume_table_get(s : BiostructvolumeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_table_set(s : BiostructvolumeTable, i : Int, v : Double) -> BiostructvolumeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_table_sum(s : BiostructvolumeTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_table_mean(s : BiostructvolumeTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_table_scale(s : BiostructvolumeTable, f : Double) -> BiostructvolumeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_table_add(a : BiostructvolumeTable, b : BiostructvolumeTable) -> BiostructvolumeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_table_copy(s : BiostructvolumeTable) -> BiostructvolumeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_table_fill(s : BiostructvolumeTable, v : Double) -> BiostructvolumeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_table_min(s : BiostructvolumeTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_table_max(s : BiostructvolumeTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_table_to_string(s : BiostructvolumeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_graphn_make(size : Int) -> BiostructvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_graphn_len(s : BiostructvolumeGraphN) -> Int { s.size }

pub fn bio_struct_volume_graphn_get(s : BiostructvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_graphn_set(s : BiostructvolumeGraphN, i : Int, v : Double) -> BiostructvolumeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_graphn_sum(s : BiostructvolumeGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_graphn_mean(s : BiostructvolumeGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_graphn_scale(s : BiostructvolumeGraphN, f : Double) -> BiostructvolumeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_graphn_add(a : BiostructvolumeGraphN, b : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_graphn_copy(s : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_graphn_fill(s : BiostructvolumeGraphN, v : Double) -> BiostructvolumeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_graphn_min(s : BiostructvolumeGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_graphn_max(s : BiostructvolumeGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_graphn_to_string(s : BiostructvolumeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_node_make(size : Int) -> BiostructvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_node_len(s : BiostructvolumeNode) -> Int { s.size }

pub fn bio_struct_volume_node_get(s : BiostructvolumeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_node_set(s : BiostructvolumeNode, i : Int, v : Double) -> BiostructvolumeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_node_sum(s : BiostructvolumeNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_node_mean(s : BiostructvolumeNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_node_scale(s : BiostructvolumeNode, f : Double) -> BiostructvolumeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_node_add(a : BiostructvolumeNode, b : BiostructvolumeNode) -> BiostructvolumeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_node_copy(s : BiostructvolumeNode) -> BiostructvolumeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_node_fill(s : BiostructvolumeNode, v : Double) -> BiostructvolumeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_node_min(s : BiostructvolumeNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_node_max(s : BiostructvolumeNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_node_to_string(s : BiostructvolumeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_edge_make(size : Int) -> BiostructvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_edge_len(s : BiostructvolumeEdge) -> Int { s.size }

pub fn bio_struct_volume_edge_get(s : BiostructvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_edge_set(s : BiostructvolumeEdge, i : Int, v : Double) -> BiostructvolumeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_edge_sum(s : BiostructvolumeEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_edge_mean(s : BiostructvolumeEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_edge_scale(s : BiostructvolumeEdge, f : Double) -> BiostructvolumeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_edge_add(a : BiostructvolumeEdge, b : BiostructvolumeEdge) -> BiostructvolumeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_edge_copy(s : BiostructvolumeEdge) -> BiostructvolumeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_edge_fill(s : BiostructvolumeEdge, v : Double) -> BiostructvolumeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_edge_min(s : BiostructvolumeEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_edge_max(s : BiostructvolumeEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_edge_to_string(s : BiostructvolumeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_path_make(size : Int) -> BiostructvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_path_len(s : BiostructvolumePath) -> Int { s.size }

pub fn bio_struct_volume_path_get(s : BiostructvolumePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_path_set(s : BiostructvolumePath, i : Int, v : Double) -> BiostructvolumePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_path_sum(s : BiostructvolumePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_path_mean(s : BiostructvolumePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_path_scale(s : BiostructvolumePath, f : Double) -> BiostructvolumePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_path_add(a : BiostructvolumePath, b : BiostructvolumePath) -> BiostructvolumePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_path_copy(s : BiostructvolumePath) -> BiostructvolumePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_path_fill(s : BiostructvolumePath, v : Double) -> BiostructvolumePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_path_min(s : BiostructvolumePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_path_max(s : BiostructvolumePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_path_to_string(s : BiostructvolumePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cluster_make(size : Int) -> BiostructvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_cluster_len(s : BiostructvolumeCluster) -> Int { s.size }

pub fn bio_struct_volume_cluster_get(s : BiostructvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_cluster_set(s : BiostructvolumeCluster, i : Int, v : Double) -> BiostructvolumeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cluster_sum(s : BiostructvolumeCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_cluster_mean(s : BiostructvolumeCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_cluster_scale(s : BiostructvolumeCluster, f : Double) -> BiostructvolumeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cluster_add(a : BiostructvolumeCluster, b : BiostructvolumeCluster) -> BiostructvolumeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_cluster_copy(s : BiostructvolumeCluster) -> BiostructvolumeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cluster_fill(s : BiostructvolumeCluster, v : Double) -> BiostructvolumeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cluster_min(s : BiostructvolumeCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_cluster_max(s : BiostructvolumeCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_cluster_to_string(s : BiostructvolumeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_model_make(size : Int) -> BiostructvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_model_len(s : BiostructvolumeModel) -> Int { s.size }

pub fn bio_struct_volume_model_get(s : BiostructvolumeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_model_set(s : BiostructvolumeModel, i : Int, v : Double) -> BiostructvolumeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_model_sum(s : BiostructvolumeModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_model_mean(s : BiostructvolumeModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_model_scale(s : BiostructvolumeModel, f : Double) -> BiostructvolumeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_model_add(a : BiostructvolumeModel, b : BiostructvolumeModel) -> BiostructvolumeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_model_copy(s : BiostructvolumeModel) -> BiostructvolumeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_model_fill(s : BiostructvolumeModel, v : Double) -> BiostructvolumeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_model_min(s : BiostructvolumeModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_model_max(s : BiostructvolumeModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_model_to_string(s : BiostructvolumeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_layer_make(size : Int) -> BiostructvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_layer_len(s : BiostructvolumeLayer) -> Int { s.size }

pub fn bio_struct_volume_layer_get(s : BiostructvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_layer_set(s : BiostructvolumeLayer, i : Int, v : Double) -> BiostructvolumeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_layer_sum(s : BiostructvolumeLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_layer_mean(s : BiostructvolumeLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_layer_scale(s : BiostructvolumeLayer, f : Double) -> BiostructvolumeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_layer_add(a : BiostructvolumeLayer, b : BiostructvolumeLayer) -> BiostructvolumeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_layer_copy(s : BiostructvolumeLayer) -> BiostructvolumeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_layer_fill(s : BiostructvolumeLayer, v : Double) -> BiostructvolumeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_layer_min(s : BiostructvolumeLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_layer_max(s : BiostructvolumeLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_layer_to_string(s : BiostructvolumeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_buffer_make(size : Int) -> BiostructvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_buffer_len(s : BiostructvolumeBuffer) -> Int { s.size }

pub fn bio_struct_volume_buffer_get(s : BiostructvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_buffer_set(s : BiostructvolumeBuffer, i : Int, v : Double) -> BiostructvolumeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_buffer_sum(s : BiostructvolumeBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_buffer_mean(s : BiostructvolumeBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_buffer_scale(s : BiostructvolumeBuffer, f : Double) -> BiostructvolumeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_buffer_add(a : BiostructvolumeBuffer, b : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_buffer_copy(s : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_buffer_fill(s : BiostructvolumeBuffer, v : Double) -> BiostructvolumeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_buffer_min(s : BiostructvolumeBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_buffer_max(s : BiostructvolumeBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_buffer_to_string(s : BiostructvolumeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cursor_make(size : Int) -> BiostructvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_cursor_len(s : BiostructvolumeCursor) -> Int { s.size }

pub fn bio_struct_volume_cursor_get(s : BiostructvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_cursor_set(s : BiostructvolumeCursor, i : Int, v : Double) -> BiostructvolumeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cursor_sum(s : BiostructvolumeCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_cursor_mean(s : BiostructvolumeCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_cursor_scale(s : BiostructvolumeCursor, f : Double) -> BiostructvolumeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cursor_add(a : BiostructvolumeCursor, b : BiostructvolumeCursor) -> BiostructvolumeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_cursor_copy(s : BiostructvolumeCursor) -> BiostructvolumeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cursor_fill(s : BiostructvolumeCursor, v : Double) -> BiostructvolumeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_cursor_min(s : BiostructvolumeCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_cursor_max(s : BiostructvolumeCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_cursor_to_string(s : BiostructvolumeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_view_make(size : Int) -> BiostructvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_view_len(s : BiostructvolumeView) -> Int { s.size }

pub fn bio_struct_volume_view_get(s : BiostructvolumeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_view_set(s : BiostructvolumeView, i : Int, v : Double) -> BiostructvolumeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_view_sum(s : BiostructvolumeView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_view_mean(s : BiostructvolumeView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_view_scale(s : BiostructvolumeView, f : Double) -> BiostructvolumeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_view_add(a : BiostructvolumeView, b : BiostructvolumeView) -> BiostructvolumeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_view_copy(s : BiostructvolumeView) -> BiostructvolumeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_view_fill(s : BiostructvolumeView, v : Double) -> BiostructvolumeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_view_min(s : BiostructvolumeView) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_view_max(s : BiostructvolumeView) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_view_to_string(s : BiostructvolumeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_range_make(size : Int) -> BiostructvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_range_len(s : BiostructvolumeRange) -> Int { s.size }

pub fn bio_struct_volume_range_get(s : BiostructvolumeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_range_set(s : BiostructvolumeRange, i : Int, v : Double) -> BiostructvolumeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_range_sum(s : BiostructvolumeRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_range_mean(s : BiostructvolumeRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_range_scale(s : BiostructvolumeRange, f : Double) -> BiostructvolumeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_range_add(a : BiostructvolumeRange, b : BiostructvolumeRange) -> BiostructvolumeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_range_copy(s : BiostructvolumeRange) -> BiostructvolumeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_range_fill(s : BiostructvolumeRange, v : Double) -> BiostructvolumeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_range_min(s : BiostructvolumeRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_range_max(s : BiostructvolumeRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_range_to_string(s : BiostructvolumeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_slice_make(size : Int) -> BiostructvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_slice_len(s : BiostructvolumeSlice) -> Int { s.size }

pub fn bio_struct_volume_slice_get(s : BiostructvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_slice_set(s : BiostructvolumeSlice, i : Int, v : Double) -> BiostructvolumeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_slice_sum(s : BiostructvolumeSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_volume_slice_mean(s : BiostructvolumeSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_volume_slice_scale(s : BiostructvolumeSlice, f : Double) -> BiostructvolumeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_slice_add(a : BiostructvolumeSlice, b : BiostructvolumeSlice) -> BiostructvolumeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_volume_slice_copy(s : BiostructvolumeSlice) -> BiostructvolumeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_slice_fill(s : BiostructvolumeSlice, v : Double) -> BiostructvolumeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_volume_slice_min(s : BiostructvolumeSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_volume_slice_max(s : BiostructvolumeSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_volume_slice_to_string(s : BiostructvolumeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

