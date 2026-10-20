///===
/// extcore/bio_struct_symmetry

pub(all) struct BiostructsymmetryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_symmetry_make_point(x : Double, y : Double) -> BiostructsymmetryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_symmetry_make_point3(x : Double, y : Double, z : Double) -> BiostructsymmetryPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructsymmetryPoint::x(self : BiostructsymmetryPoint) -> Double { self.x }

pub fn BiostructsymmetryPoint::y(self : BiostructsymmetryPoint) -> Double { self.y }

pub fn BiostructsymmetryPoint::z(self : BiostructsymmetryPoint) -> Double { self.z }

pub fn BiostructsymmetryPoint::label(self : BiostructsymmetryPoint) -> Int { self.label }

pub fn BiostructsymmetryPoint::dist(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructsymmetryPoint::add(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructsymmetryPoint::sub(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructsymmetryPoint::scale(self : BiostructsymmetryPoint, s : Double) -> BiostructsymmetryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructsymmetryPoint::dot(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructsymmetryPoint::cross(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructsymmetryPoint::norm(self : BiostructsymmetryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructsymmetryPoint::normalize(self : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsymmetryPoint::negate(self : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructsymmetryPoint::mid(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructsymmetryPoint::lerp(self : BiostructsymmetryPoint, other : BiostructsymmetryPoint, t : Double) -> BiostructsymmetryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructsymmetryPoint::to_string(self : BiostructsymmetryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructsymmetrySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_symmetry_make_series(vals : Array[Double], name : String) -> BiostructsymmetrySeries {
  { vals, name, meta: 0 }
}

pub fn BiostructsymmetrySeries::len(self : BiostructsymmetrySeries) -> Int { self.vals.length() }

pub fn BiostructsymmetrySeries::sum(self : BiostructsymmetrySeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructsymmetrySeries::mean(self : BiostructsymmetrySeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructsymmetrySeries::min(self : BiostructsymmetrySeries) -> Double { @_common.min(self.vals) }

pub fn BiostructsymmetrySeries::max(self : BiostructsymmetrySeries) -> Double { @_common.max(self.vals) }

pub fn BiostructsymmetrySeries::range(self : BiostructsymmetrySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructsymmetrySeries::variance(self : BiostructsymmetrySeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructsymmetrySeries::std(self : BiostructsymmetrySeries) -> Double { @_common.std(self.vals) }

pub fn BiostructsymmetrySeries::median(self : BiostructsymmetrySeries) -> Double { @_common.median(self.vals) }

pub fn BiostructsymmetrySeries::scale(self : BiostructsymmetrySeries, f : Double) -> BiostructsymmetrySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructsymmetrySeries::add(self : BiostructsymmetrySeries, other : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructsymmetrySeries::sub(self : BiostructsymmetrySeries, other : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructsymmetrySeries::normalize(self : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructsymmetrySeries::cumsum(self : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructsymmetrySeries::to_string(self : BiostructsymmetrySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsymmetryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_symmetry_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsymmetryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_symmetry_matrix_identity(n : Int) -> BiostructsymmetryMatrix {
  let m = bio_struct_symmetry_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructsymmetryMatrix::get(self : BiostructsymmetryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructsymmetryMatrix::transpose(self : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  let result = bio_struct_symmetry_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructsymmetryMatrix::add(self : BiostructsymmetryMatrix, other : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_symmetry_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructsymmetryMatrix::scale(self : BiostructsymmetryMatrix, s : Double) -> BiostructsymmetryMatrix {
  let result = bio_struct_symmetry_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructsymmetryMatrix::multiply(self : BiostructsymmetryMatrix, other : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  if self.cols != other.rows { return bio_struct_symmetry_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_symmetry_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructsymmetryMatrix::trace(self : BiostructsymmetryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructsymmetryMatrix::det(self : BiostructsymmetryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructsymmetryMatrix::norm(self : BiostructsymmetryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructsymmetryMatrix::to_string(self : BiostructsymmetryMatrix) -> String {
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

pub(all) struct BiostructsymmetryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_symmetry_make_vector(comps : Array[Double]) -> BiostructsymmetryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_symmetry_vector_zero(dim : Int) -> BiostructsymmetryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructsymmetryVector::add(self : BiostructsymmetryVector, other : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsymmetryVector::sub(self : BiostructsymmetryVector, other : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsymmetryVector::scale(self : BiostructsymmetryVector, s : Double) -> BiostructsymmetryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructsymmetryVector::dot(self : BiostructsymmetryVector, other : BiostructsymmetryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructsymmetryVector::norm(self : BiostructsymmetryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructsymmetryVector::normalize(self : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsymmetryVector::dist(self : BiostructsymmetryVector, other : BiostructsymmetryVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructsymmetryVector::to_string(self : BiostructsymmetryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_symmetry_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_symmetry_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_symmetry_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_symmetry_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_symmetry_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_symmetry_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_symmetry_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_symmetry_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_symmetry_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_symmetry_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_symmetry_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_symmetry_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_symmetry_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_symmetry_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_symmetry_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_symmetry_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_symmetry_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_symmetry_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_symmetry_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_symmetry_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_symmetry_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_symmetry_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_symmetry_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_symmetry_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_symmetry_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_symmetry_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_symmetry_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_symmetry_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_symmetry_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsymmetryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_frame_make(size : Int) -> BiostructsymmetryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_frame_len(s : BiostructsymmetryFrame) -> Int { s.size }

pub fn bio_struct_symmetry_frame_get(s : BiostructsymmetryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_frame_set(s : BiostructsymmetryFrame, i : Int, v : Double) -> BiostructsymmetryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_frame_sum(s : BiostructsymmetryFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_frame_mean(s : BiostructsymmetryFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_frame_scale(s : BiostructsymmetryFrame, f : Double) -> BiostructsymmetryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_frame_add(a : BiostructsymmetryFrame, b : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_frame_copy(s : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_frame_fill(s : BiostructsymmetryFrame, v : Double) -> BiostructsymmetryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_frame_min(s : BiostructsymmetryFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_frame_max(s : BiostructsymmetryFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_frame_to_string(s : BiostructsymmetryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_table_make(size : Int) -> BiostructsymmetryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_table_len(s : BiostructsymmetryTable) -> Int { s.size }

pub fn bio_struct_symmetry_table_get(s : BiostructsymmetryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_table_set(s : BiostructsymmetryTable, i : Int, v : Double) -> BiostructsymmetryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_table_sum(s : BiostructsymmetryTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_table_mean(s : BiostructsymmetryTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_table_scale(s : BiostructsymmetryTable, f : Double) -> BiostructsymmetryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_table_add(a : BiostructsymmetryTable, b : BiostructsymmetryTable) -> BiostructsymmetryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_table_copy(s : BiostructsymmetryTable) -> BiostructsymmetryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_table_fill(s : BiostructsymmetryTable, v : Double) -> BiostructsymmetryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_table_min(s : BiostructsymmetryTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_table_max(s : BiostructsymmetryTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_table_to_string(s : BiostructsymmetryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_graphn_make(size : Int) -> BiostructsymmetryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_graphn_len(s : BiostructsymmetryGraphN) -> Int { s.size }

pub fn bio_struct_symmetry_graphn_get(s : BiostructsymmetryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_graphn_set(s : BiostructsymmetryGraphN, i : Int, v : Double) -> BiostructsymmetryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_graphn_sum(s : BiostructsymmetryGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_graphn_mean(s : BiostructsymmetryGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_graphn_scale(s : BiostructsymmetryGraphN, f : Double) -> BiostructsymmetryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_graphn_add(a : BiostructsymmetryGraphN, b : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_graphn_copy(s : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_graphn_fill(s : BiostructsymmetryGraphN, v : Double) -> BiostructsymmetryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_graphn_min(s : BiostructsymmetryGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_graphn_max(s : BiostructsymmetryGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_graphn_to_string(s : BiostructsymmetryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_node_make(size : Int) -> BiostructsymmetryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_node_len(s : BiostructsymmetryNode) -> Int { s.size }

pub fn bio_struct_symmetry_node_get(s : BiostructsymmetryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_node_set(s : BiostructsymmetryNode, i : Int, v : Double) -> BiostructsymmetryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_node_sum(s : BiostructsymmetryNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_node_mean(s : BiostructsymmetryNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_node_scale(s : BiostructsymmetryNode, f : Double) -> BiostructsymmetryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_node_add(a : BiostructsymmetryNode, b : BiostructsymmetryNode) -> BiostructsymmetryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_node_copy(s : BiostructsymmetryNode) -> BiostructsymmetryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_node_fill(s : BiostructsymmetryNode, v : Double) -> BiostructsymmetryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_node_min(s : BiostructsymmetryNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_node_max(s : BiostructsymmetryNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_node_to_string(s : BiostructsymmetryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_edge_make(size : Int) -> BiostructsymmetryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_edge_len(s : BiostructsymmetryEdge) -> Int { s.size }

pub fn bio_struct_symmetry_edge_get(s : BiostructsymmetryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_edge_set(s : BiostructsymmetryEdge, i : Int, v : Double) -> BiostructsymmetryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_edge_sum(s : BiostructsymmetryEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_edge_mean(s : BiostructsymmetryEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_edge_scale(s : BiostructsymmetryEdge, f : Double) -> BiostructsymmetryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_edge_add(a : BiostructsymmetryEdge, b : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_edge_copy(s : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_edge_fill(s : BiostructsymmetryEdge, v : Double) -> BiostructsymmetryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_edge_min(s : BiostructsymmetryEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_edge_max(s : BiostructsymmetryEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_edge_to_string(s : BiostructsymmetryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_path_make(size : Int) -> BiostructsymmetryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_path_len(s : BiostructsymmetryPath) -> Int { s.size }

pub fn bio_struct_symmetry_path_get(s : BiostructsymmetryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_path_set(s : BiostructsymmetryPath, i : Int, v : Double) -> BiostructsymmetryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_path_sum(s : BiostructsymmetryPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_path_mean(s : BiostructsymmetryPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_path_scale(s : BiostructsymmetryPath, f : Double) -> BiostructsymmetryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_path_add(a : BiostructsymmetryPath, b : BiostructsymmetryPath) -> BiostructsymmetryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_path_copy(s : BiostructsymmetryPath) -> BiostructsymmetryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_path_fill(s : BiostructsymmetryPath, v : Double) -> BiostructsymmetryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_path_min(s : BiostructsymmetryPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_path_max(s : BiostructsymmetryPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_path_to_string(s : BiostructsymmetryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cluster_make(size : Int) -> BiostructsymmetryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_cluster_len(s : BiostructsymmetryCluster) -> Int { s.size }

pub fn bio_struct_symmetry_cluster_get(s : BiostructsymmetryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_cluster_set(s : BiostructsymmetryCluster, i : Int, v : Double) -> BiostructsymmetryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cluster_sum(s : BiostructsymmetryCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_cluster_mean(s : BiostructsymmetryCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_cluster_scale(s : BiostructsymmetryCluster, f : Double) -> BiostructsymmetryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cluster_add(a : BiostructsymmetryCluster, b : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_cluster_copy(s : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cluster_fill(s : BiostructsymmetryCluster, v : Double) -> BiostructsymmetryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cluster_min(s : BiostructsymmetryCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_cluster_max(s : BiostructsymmetryCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_cluster_to_string(s : BiostructsymmetryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_model_make(size : Int) -> BiostructsymmetryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_model_len(s : BiostructsymmetryModel) -> Int { s.size }

pub fn bio_struct_symmetry_model_get(s : BiostructsymmetryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_model_set(s : BiostructsymmetryModel, i : Int, v : Double) -> BiostructsymmetryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_model_sum(s : BiostructsymmetryModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_model_mean(s : BiostructsymmetryModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_model_scale(s : BiostructsymmetryModel, f : Double) -> BiostructsymmetryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_model_add(a : BiostructsymmetryModel, b : BiostructsymmetryModel) -> BiostructsymmetryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_model_copy(s : BiostructsymmetryModel) -> BiostructsymmetryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_model_fill(s : BiostructsymmetryModel, v : Double) -> BiostructsymmetryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_model_min(s : BiostructsymmetryModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_model_max(s : BiostructsymmetryModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_model_to_string(s : BiostructsymmetryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_layer_make(size : Int) -> BiostructsymmetryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_layer_len(s : BiostructsymmetryLayer) -> Int { s.size }

pub fn bio_struct_symmetry_layer_get(s : BiostructsymmetryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_layer_set(s : BiostructsymmetryLayer, i : Int, v : Double) -> BiostructsymmetryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_layer_sum(s : BiostructsymmetryLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_layer_mean(s : BiostructsymmetryLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_layer_scale(s : BiostructsymmetryLayer, f : Double) -> BiostructsymmetryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_layer_add(a : BiostructsymmetryLayer, b : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_layer_copy(s : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_layer_fill(s : BiostructsymmetryLayer, v : Double) -> BiostructsymmetryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_layer_min(s : BiostructsymmetryLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_layer_max(s : BiostructsymmetryLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_layer_to_string(s : BiostructsymmetryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_buffer_make(size : Int) -> BiostructsymmetryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_buffer_len(s : BiostructsymmetryBuffer) -> Int { s.size }

pub fn bio_struct_symmetry_buffer_get(s : BiostructsymmetryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_buffer_set(s : BiostructsymmetryBuffer, i : Int, v : Double) -> BiostructsymmetryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_buffer_sum(s : BiostructsymmetryBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_buffer_mean(s : BiostructsymmetryBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_buffer_scale(s : BiostructsymmetryBuffer, f : Double) -> BiostructsymmetryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_buffer_add(a : BiostructsymmetryBuffer, b : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_buffer_copy(s : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_buffer_fill(s : BiostructsymmetryBuffer, v : Double) -> BiostructsymmetryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_buffer_min(s : BiostructsymmetryBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_buffer_max(s : BiostructsymmetryBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_buffer_to_string(s : BiostructsymmetryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cursor_make(size : Int) -> BiostructsymmetryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_cursor_len(s : BiostructsymmetryCursor) -> Int { s.size }

pub fn bio_struct_symmetry_cursor_get(s : BiostructsymmetryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_cursor_set(s : BiostructsymmetryCursor, i : Int, v : Double) -> BiostructsymmetryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cursor_sum(s : BiostructsymmetryCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_cursor_mean(s : BiostructsymmetryCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_cursor_scale(s : BiostructsymmetryCursor, f : Double) -> BiostructsymmetryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cursor_add(a : BiostructsymmetryCursor, b : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_cursor_copy(s : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cursor_fill(s : BiostructsymmetryCursor, v : Double) -> BiostructsymmetryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_cursor_min(s : BiostructsymmetryCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_cursor_max(s : BiostructsymmetryCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_cursor_to_string(s : BiostructsymmetryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_view_make(size : Int) -> BiostructsymmetryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_view_len(s : BiostructsymmetryView) -> Int { s.size }

pub fn bio_struct_symmetry_view_get(s : BiostructsymmetryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_view_set(s : BiostructsymmetryView, i : Int, v : Double) -> BiostructsymmetryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_view_sum(s : BiostructsymmetryView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_view_mean(s : BiostructsymmetryView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_view_scale(s : BiostructsymmetryView, f : Double) -> BiostructsymmetryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_view_add(a : BiostructsymmetryView, b : BiostructsymmetryView) -> BiostructsymmetryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_view_copy(s : BiostructsymmetryView) -> BiostructsymmetryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_view_fill(s : BiostructsymmetryView, v : Double) -> BiostructsymmetryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_view_min(s : BiostructsymmetryView) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_view_max(s : BiostructsymmetryView) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_view_to_string(s : BiostructsymmetryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_range_make(size : Int) -> BiostructsymmetryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_range_len(s : BiostructsymmetryRange) -> Int { s.size }

pub fn bio_struct_symmetry_range_get(s : BiostructsymmetryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_range_set(s : BiostructsymmetryRange, i : Int, v : Double) -> BiostructsymmetryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_range_sum(s : BiostructsymmetryRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_range_mean(s : BiostructsymmetryRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_range_scale(s : BiostructsymmetryRange, f : Double) -> BiostructsymmetryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_range_add(a : BiostructsymmetryRange, b : BiostructsymmetryRange) -> BiostructsymmetryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_range_copy(s : BiostructsymmetryRange) -> BiostructsymmetryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_range_fill(s : BiostructsymmetryRange, v : Double) -> BiostructsymmetryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_range_min(s : BiostructsymmetryRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_range_max(s : BiostructsymmetryRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_range_to_string(s : BiostructsymmetryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetrySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_slice_make(size : Int) -> BiostructsymmetrySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_slice_len(s : BiostructsymmetrySlice) -> Int { s.size }

pub fn bio_struct_symmetry_slice_get(s : BiostructsymmetrySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_slice_set(s : BiostructsymmetrySlice, i : Int, v : Double) -> BiostructsymmetrySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_slice_sum(s : BiostructsymmetrySlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_symmetry_slice_mean(s : BiostructsymmetrySlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_symmetry_slice_scale(s : BiostructsymmetrySlice, f : Double) -> BiostructsymmetrySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_slice_add(a : BiostructsymmetrySlice, b : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_symmetry_slice_copy(s : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_slice_fill(s : BiostructsymmetrySlice, v : Double) -> BiostructsymmetrySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_symmetry_slice_min(s : BiostructsymmetrySlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_symmetry_slice_max(s : BiostructsymmetrySlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_symmetry_slice_to_string(s : BiostructsymmetrySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

