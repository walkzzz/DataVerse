///===
/// extcore/bio_struct_contact

pub(all) struct BiostructcontactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_contact_make_point(x : Double, y : Double) -> BiostructcontactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_contact_make_point3(x : Double, y : Double, z : Double) -> BiostructcontactPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructcontactPoint::x(self : BiostructcontactPoint) -> Double { self.x }

pub fn BiostructcontactPoint::y(self : BiostructcontactPoint) -> Double { self.y }

pub fn BiostructcontactPoint::z(self : BiostructcontactPoint) -> Double { self.z }

pub fn BiostructcontactPoint::label(self : BiostructcontactPoint) -> Int { self.label }

pub fn BiostructcontactPoint::dist(self : BiostructcontactPoint, other : BiostructcontactPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructcontactPoint::add(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructcontactPoint::sub(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructcontactPoint::scale(self : BiostructcontactPoint, s : Double) -> BiostructcontactPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructcontactPoint::dot(self : BiostructcontactPoint, other : BiostructcontactPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructcontactPoint::cross(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructcontactPoint::norm(self : BiostructcontactPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructcontactPoint::normalize(self : BiostructcontactPoint) -> BiostructcontactPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructcontactPoint::negate(self : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructcontactPoint::mid(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructcontactPoint::lerp(self : BiostructcontactPoint, other : BiostructcontactPoint, t : Double) -> BiostructcontactPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructcontactPoint::to_string(self : BiostructcontactPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructcontactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_contact_make_series(vals : Array[Double], name : String) -> BiostructcontactSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructcontactSeries::len(self : BiostructcontactSeries) -> Int { self.vals.length() }

pub fn BiostructcontactSeries::sum(self : BiostructcontactSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructcontactSeries::mean(self : BiostructcontactSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructcontactSeries::min(self : BiostructcontactSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructcontactSeries::max(self : BiostructcontactSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructcontactSeries::range(self : BiostructcontactSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructcontactSeries::variance(self : BiostructcontactSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructcontactSeries::std(self : BiostructcontactSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructcontactSeries::median(self : BiostructcontactSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructcontactSeries::scale(self : BiostructcontactSeries, f : Double) -> BiostructcontactSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructcontactSeries::add(self : BiostructcontactSeries, other : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructcontactSeries::sub(self : BiostructcontactSeries, other : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructcontactSeries::normalize(self : BiostructcontactSeries) -> BiostructcontactSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructcontactSeries::cumsum(self : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructcontactSeries::to_string(self : BiostructcontactSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructcontactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_contact_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructcontactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_contact_matrix_identity(n : Int) -> BiostructcontactMatrix {
  let m = bio_struct_contact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructcontactMatrix::get(self : BiostructcontactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructcontactMatrix::transpose(self : BiostructcontactMatrix) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructcontactMatrix::add(self : BiostructcontactMatrix, other : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_contact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructcontactMatrix::scale(self : BiostructcontactMatrix, s : Double) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructcontactMatrix::multiply(self : BiostructcontactMatrix, other : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if self.cols != other.rows { return bio_struct_contact_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_contact_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructcontactMatrix::trace(self : BiostructcontactMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructcontactMatrix::det(self : BiostructcontactMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructcontactMatrix::norm(self : BiostructcontactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructcontactMatrix::to_string(self : BiostructcontactMatrix) -> String {
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

pub(all) struct BiostructcontactVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_contact_make_vector(comps : Array[Double]) -> BiostructcontactVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_contact_vector_zero(dim : Int) -> BiostructcontactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructcontactVector::add(self : BiostructcontactVector, other : BiostructcontactVector) -> BiostructcontactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructcontactVector::sub(self : BiostructcontactVector, other : BiostructcontactVector) -> BiostructcontactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructcontactVector::scale(self : BiostructcontactVector, s : Double) -> BiostructcontactVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructcontactVector::dot(self : BiostructcontactVector, other : BiostructcontactVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructcontactVector::norm(self : BiostructcontactVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructcontactVector::normalize(self : BiostructcontactVector) -> BiostructcontactVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructcontactVector::dist(self : BiostructcontactVector, other : BiostructcontactVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructcontactVector::to_string(self : BiostructcontactVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_contact_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_contact_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_contact_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_contact_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_contact_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_contact_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_contact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_contact_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_contact_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_contact_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_contact_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_contact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_contact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_contact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_contact_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_contact_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_contact_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_contact_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_contact_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_contact_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_contact_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_contact_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_contact_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_contact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_contact_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_contact_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_contact_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_contact_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_contact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructcontactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_frame_make(size : Int) -> BiostructcontactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_frame_len(s : BiostructcontactFrame) -> Int { s.size }

pub fn bio_struct_contact_frame_get(s : BiostructcontactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_frame_set(s : BiostructcontactFrame, i : Int, v : Double) -> BiostructcontactFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_frame_sum(s : BiostructcontactFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_frame_mean(s : BiostructcontactFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_frame_scale(s : BiostructcontactFrame, f : Double) -> BiostructcontactFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_frame_add(a : BiostructcontactFrame, b : BiostructcontactFrame) -> BiostructcontactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_frame_copy(s : BiostructcontactFrame) -> BiostructcontactFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_frame_fill(s : BiostructcontactFrame, v : Double) -> BiostructcontactFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_frame_min(s : BiostructcontactFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_frame_max(s : BiostructcontactFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_frame_to_string(s : BiostructcontactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_table_make(size : Int) -> BiostructcontactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_table_len(s : BiostructcontactTable) -> Int { s.size }

pub fn bio_struct_contact_table_get(s : BiostructcontactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_table_set(s : BiostructcontactTable, i : Int, v : Double) -> BiostructcontactTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_table_sum(s : BiostructcontactTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_table_mean(s : BiostructcontactTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_table_scale(s : BiostructcontactTable, f : Double) -> BiostructcontactTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_table_add(a : BiostructcontactTable, b : BiostructcontactTable) -> BiostructcontactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_table_copy(s : BiostructcontactTable) -> BiostructcontactTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_table_fill(s : BiostructcontactTable, v : Double) -> BiostructcontactTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_table_min(s : BiostructcontactTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_table_max(s : BiostructcontactTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_table_to_string(s : BiostructcontactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_graphn_make(size : Int) -> BiostructcontactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_graphn_len(s : BiostructcontactGraphN) -> Int { s.size }

pub fn bio_struct_contact_graphn_get(s : BiostructcontactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_graphn_set(s : BiostructcontactGraphN, i : Int, v : Double) -> BiostructcontactGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_graphn_sum(s : BiostructcontactGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_graphn_mean(s : BiostructcontactGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_graphn_scale(s : BiostructcontactGraphN, f : Double) -> BiostructcontactGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_graphn_add(a : BiostructcontactGraphN, b : BiostructcontactGraphN) -> BiostructcontactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_graphn_copy(s : BiostructcontactGraphN) -> BiostructcontactGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_graphn_fill(s : BiostructcontactGraphN, v : Double) -> BiostructcontactGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_graphn_min(s : BiostructcontactGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_graphn_max(s : BiostructcontactGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_graphn_to_string(s : BiostructcontactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_node_make(size : Int) -> BiostructcontactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_node_len(s : BiostructcontactNode) -> Int { s.size }

pub fn bio_struct_contact_node_get(s : BiostructcontactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_node_set(s : BiostructcontactNode, i : Int, v : Double) -> BiostructcontactNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_node_sum(s : BiostructcontactNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_node_mean(s : BiostructcontactNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_node_scale(s : BiostructcontactNode, f : Double) -> BiostructcontactNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_node_add(a : BiostructcontactNode, b : BiostructcontactNode) -> BiostructcontactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_node_copy(s : BiostructcontactNode) -> BiostructcontactNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_node_fill(s : BiostructcontactNode, v : Double) -> BiostructcontactNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_node_min(s : BiostructcontactNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_node_max(s : BiostructcontactNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_node_to_string(s : BiostructcontactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_edge_make(size : Int) -> BiostructcontactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_edge_len(s : BiostructcontactEdge) -> Int { s.size }

pub fn bio_struct_contact_edge_get(s : BiostructcontactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_edge_set(s : BiostructcontactEdge, i : Int, v : Double) -> BiostructcontactEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_edge_sum(s : BiostructcontactEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_edge_mean(s : BiostructcontactEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_edge_scale(s : BiostructcontactEdge, f : Double) -> BiostructcontactEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_edge_add(a : BiostructcontactEdge, b : BiostructcontactEdge) -> BiostructcontactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_edge_copy(s : BiostructcontactEdge) -> BiostructcontactEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_edge_fill(s : BiostructcontactEdge, v : Double) -> BiostructcontactEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_edge_min(s : BiostructcontactEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_edge_max(s : BiostructcontactEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_edge_to_string(s : BiostructcontactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_path_make(size : Int) -> BiostructcontactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_path_len(s : BiostructcontactPath) -> Int { s.size }

pub fn bio_struct_contact_path_get(s : BiostructcontactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_path_set(s : BiostructcontactPath, i : Int, v : Double) -> BiostructcontactPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_path_sum(s : BiostructcontactPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_path_mean(s : BiostructcontactPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_path_scale(s : BiostructcontactPath, f : Double) -> BiostructcontactPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_path_add(a : BiostructcontactPath, b : BiostructcontactPath) -> BiostructcontactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_path_copy(s : BiostructcontactPath) -> BiostructcontactPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_path_fill(s : BiostructcontactPath, v : Double) -> BiostructcontactPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_path_min(s : BiostructcontactPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_path_max(s : BiostructcontactPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_path_to_string(s : BiostructcontactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cluster_make(size : Int) -> BiostructcontactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_cluster_len(s : BiostructcontactCluster) -> Int { s.size }

pub fn bio_struct_contact_cluster_get(s : BiostructcontactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_cluster_set(s : BiostructcontactCluster, i : Int, v : Double) -> BiostructcontactCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cluster_sum(s : BiostructcontactCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_cluster_mean(s : BiostructcontactCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_cluster_scale(s : BiostructcontactCluster, f : Double) -> BiostructcontactCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cluster_add(a : BiostructcontactCluster, b : BiostructcontactCluster) -> BiostructcontactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_cluster_copy(s : BiostructcontactCluster) -> BiostructcontactCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cluster_fill(s : BiostructcontactCluster, v : Double) -> BiostructcontactCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cluster_min(s : BiostructcontactCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_cluster_max(s : BiostructcontactCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_cluster_to_string(s : BiostructcontactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_model_make(size : Int) -> BiostructcontactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_model_len(s : BiostructcontactModel) -> Int { s.size }

pub fn bio_struct_contact_model_get(s : BiostructcontactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_model_set(s : BiostructcontactModel, i : Int, v : Double) -> BiostructcontactModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_model_sum(s : BiostructcontactModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_model_mean(s : BiostructcontactModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_model_scale(s : BiostructcontactModel, f : Double) -> BiostructcontactModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_model_add(a : BiostructcontactModel, b : BiostructcontactModel) -> BiostructcontactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_model_copy(s : BiostructcontactModel) -> BiostructcontactModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_model_fill(s : BiostructcontactModel, v : Double) -> BiostructcontactModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_model_min(s : BiostructcontactModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_model_max(s : BiostructcontactModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_model_to_string(s : BiostructcontactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_layer_make(size : Int) -> BiostructcontactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_layer_len(s : BiostructcontactLayer) -> Int { s.size }

pub fn bio_struct_contact_layer_get(s : BiostructcontactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_layer_set(s : BiostructcontactLayer, i : Int, v : Double) -> BiostructcontactLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_layer_sum(s : BiostructcontactLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_layer_mean(s : BiostructcontactLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_layer_scale(s : BiostructcontactLayer, f : Double) -> BiostructcontactLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_layer_add(a : BiostructcontactLayer, b : BiostructcontactLayer) -> BiostructcontactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_layer_copy(s : BiostructcontactLayer) -> BiostructcontactLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_layer_fill(s : BiostructcontactLayer, v : Double) -> BiostructcontactLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_layer_min(s : BiostructcontactLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_layer_max(s : BiostructcontactLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_layer_to_string(s : BiostructcontactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_buffer_make(size : Int) -> BiostructcontactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_buffer_len(s : BiostructcontactBuffer) -> Int { s.size }

pub fn bio_struct_contact_buffer_get(s : BiostructcontactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_buffer_set(s : BiostructcontactBuffer, i : Int, v : Double) -> BiostructcontactBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_buffer_sum(s : BiostructcontactBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_buffer_mean(s : BiostructcontactBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_buffer_scale(s : BiostructcontactBuffer, f : Double) -> BiostructcontactBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_buffer_add(a : BiostructcontactBuffer, b : BiostructcontactBuffer) -> BiostructcontactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_buffer_copy(s : BiostructcontactBuffer) -> BiostructcontactBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_buffer_fill(s : BiostructcontactBuffer, v : Double) -> BiostructcontactBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_buffer_min(s : BiostructcontactBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_buffer_max(s : BiostructcontactBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_buffer_to_string(s : BiostructcontactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cursor_make(size : Int) -> BiostructcontactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_cursor_len(s : BiostructcontactCursor) -> Int { s.size }

pub fn bio_struct_contact_cursor_get(s : BiostructcontactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_cursor_set(s : BiostructcontactCursor, i : Int, v : Double) -> BiostructcontactCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cursor_sum(s : BiostructcontactCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_cursor_mean(s : BiostructcontactCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_cursor_scale(s : BiostructcontactCursor, f : Double) -> BiostructcontactCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cursor_add(a : BiostructcontactCursor, b : BiostructcontactCursor) -> BiostructcontactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_cursor_copy(s : BiostructcontactCursor) -> BiostructcontactCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cursor_fill(s : BiostructcontactCursor, v : Double) -> BiostructcontactCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_cursor_min(s : BiostructcontactCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_cursor_max(s : BiostructcontactCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_cursor_to_string(s : BiostructcontactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_view_make(size : Int) -> BiostructcontactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_view_len(s : BiostructcontactView) -> Int { s.size }

pub fn bio_struct_contact_view_get(s : BiostructcontactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_view_set(s : BiostructcontactView, i : Int, v : Double) -> BiostructcontactView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_view_sum(s : BiostructcontactView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_view_mean(s : BiostructcontactView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_view_scale(s : BiostructcontactView, f : Double) -> BiostructcontactView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_view_add(a : BiostructcontactView, b : BiostructcontactView) -> BiostructcontactView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_view_copy(s : BiostructcontactView) -> BiostructcontactView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_view_fill(s : BiostructcontactView, v : Double) -> BiostructcontactView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_view_min(s : BiostructcontactView) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_view_max(s : BiostructcontactView) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_view_to_string(s : BiostructcontactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_range_make(size : Int) -> BiostructcontactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_range_len(s : BiostructcontactRange) -> Int { s.size }

pub fn bio_struct_contact_range_get(s : BiostructcontactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_range_set(s : BiostructcontactRange, i : Int, v : Double) -> BiostructcontactRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_range_sum(s : BiostructcontactRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_range_mean(s : BiostructcontactRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_range_scale(s : BiostructcontactRange, f : Double) -> BiostructcontactRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_range_add(a : BiostructcontactRange, b : BiostructcontactRange) -> BiostructcontactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_range_copy(s : BiostructcontactRange) -> BiostructcontactRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_range_fill(s : BiostructcontactRange, v : Double) -> BiostructcontactRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_range_min(s : BiostructcontactRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_range_max(s : BiostructcontactRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_range_to_string(s : BiostructcontactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_slice_make(size : Int) -> BiostructcontactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_slice_len(s : BiostructcontactSlice) -> Int { s.size }

pub fn bio_struct_contact_slice_get(s : BiostructcontactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_slice_set(s : BiostructcontactSlice, i : Int, v : Double) -> BiostructcontactSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_slice_sum(s : BiostructcontactSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_contact_slice_mean(s : BiostructcontactSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_contact_slice_scale(s : BiostructcontactSlice, f : Double) -> BiostructcontactSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_slice_add(a : BiostructcontactSlice, b : BiostructcontactSlice) -> BiostructcontactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_contact_slice_copy(s : BiostructcontactSlice) -> BiostructcontactSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_slice_fill(s : BiostructcontactSlice, v : Double) -> BiostructcontactSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_contact_slice_min(s : BiostructcontactSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_contact_slice_max(s : BiostructcontactSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_contact_slice_to_string(s : BiostructcontactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

