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

pub fn BiostructsymmetryFrame::len(self : BiostructsymmetryFrame) -> Int { self.size }

pub fn BiostructsymmetryFrame::get(self : BiostructsymmetryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryFrame::set(self : BiostructsymmetryFrame, i : Int, v : Double) -> BiostructsymmetryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryFrame::sum(self : BiostructsymmetryFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryFrame::mean(self : BiostructsymmetryFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryFrame::scale(self : BiostructsymmetryFrame, f : Double) -> BiostructsymmetryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryFrame::add(self : BiostructsymmetryFrame, other : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryFrame::copy(self : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryFrame::fill(self : BiostructsymmetryFrame, v : Double) -> BiostructsymmetryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryFrame::min(self : BiostructsymmetryFrame) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryFrame::max(self : BiostructsymmetryFrame) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryFrame::to_string(self : BiostructsymmetryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_table_make(size : Int) -> BiostructsymmetryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryTable::len(self : BiostructsymmetryTable) -> Int { self.size }

pub fn BiostructsymmetryTable::get(self : BiostructsymmetryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryTable::set(self : BiostructsymmetryTable, i : Int, v : Double) -> BiostructsymmetryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryTable::sum(self : BiostructsymmetryTable) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryTable::mean(self : BiostructsymmetryTable) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryTable::scale(self : BiostructsymmetryTable, f : Double) -> BiostructsymmetryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryTable::add(self : BiostructsymmetryTable, other : BiostructsymmetryTable) -> BiostructsymmetryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryTable::copy(self : BiostructsymmetryTable) -> BiostructsymmetryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryTable::fill(self : BiostructsymmetryTable, v : Double) -> BiostructsymmetryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryTable::min(self : BiostructsymmetryTable) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryTable::max(self : BiostructsymmetryTable) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryTable::to_string(self : BiostructsymmetryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_graphn_make(size : Int) -> BiostructsymmetryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryGraphN::len(self : BiostructsymmetryGraphN) -> Int { self.size }

pub fn BiostructsymmetryGraphN::get(self : BiostructsymmetryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryGraphN::set(self : BiostructsymmetryGraphN, i : Int, v : Double) -> BiostructsymmetryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryGraphN::sum(self : BiostructsymmetryGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryGraphN::mean(self : BiostructsymmetryGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryGraphN::scale(self : BiostructsymmetryGraphN, f : Double) -> BiostructsymmetryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryGraphN::add(self : BiostructsymmetryGraphN, other : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryGraphN::copy(self : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryGraphN::fill(self : BiostructsymmetryGraphN, v : Double) -> BiostructsymmetryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryGraphN::min(self : BiostructsymmetryGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryGraphN::max(self : BiostructsymmetryGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryGraphN::to_string(self : BiostructsymmetryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_node_make(size : Int) -> BiostructsymmetryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryNode::len(self : BiostructsymmetryNode) -> Int { self.size }

pub fn BiostructsymmetryNode::get(self : BiostructsymmetryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryNode::set(self : BiostructsymmetryNode, i : Int, v : Double) -> BiostructsymmetryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryNode::sum(self : BiostructsymmetryNode) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryNode::mean(self : BiostructsymmetryNode) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryNode::scale(self : BiostructsymmetryNode, f : Double) -> BiostructsymmetryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryNode::add(self : BiostructsymmetryNode, other : BiostructsymmetryNode) -> BiostructsymmetryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryNode::copy(self : BiostructsymmetryNode) -> BiostructsymmetryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryNode::fill(self : BiostructsymmetryNode, v : Double) -> BiostructsymmetryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryNode::min(self : BiostructsymmetryNode) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryNode::max(self : BiostructsymmetryNode) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryNode::to_string(self : BiostructsymmetryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_edge_make(size : Int) -> BiostructsymmetryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryEdge::len(self : BiostructsymmetryEdge) -> Int { self.size }

pub fn BiostructsymmetryEdge::get(self : BiostructsymmetryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryEdge::set(self : BiostructsymmetryEdge, i : Int, v : Double) -> BiostructsymmetryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryEdge::sum(self : BiostructsymmetryEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryEdge::mean(self : BiostructsymmetryEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryEdge::scale(self : BiostructsymmetryEdge, f : Double) -> BiostructsymmetryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryEdge::add(self : BiostructsymmetryEdge, other : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryEdge::copy(self : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryEdge::fill(self : BiostructsymmetryEdge, v : Double) -> BiostructsymmetryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryEdge::min(self : BiostructsymmetryEdge) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryEdge::max(self : BiostructsymmetryEdge) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryEdge::to_string(self : BiostructsymmetryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_path_make(size : Int) -> BiostructsymmetryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryPath::len(self : BiostructsymmetryPath) -> Int { self.size }

pub fn BiostructsymmetryPath::get(self : BiostructsymmetryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryPath::set(self : BiostructsymmetryPath, i : Int, v : Double) -> BiostructsymmetryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryPath::sum(self : BiostructsymmetryPath) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryPath::mean(self : BiostructsymmetryPath) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryPath::scale(self : BiostructsymmetryPath, f : Double) -> BiostructsymmetryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryPath::add(self : BiostructsymmetryPath, other : BiostructsymmetryPath) -> BiostructsymmetryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryPath::copy(self : BiostructsymmetryPath) -> BiostructsymmetryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryPath::fill(self : BiostructsymmetryPath, v : Double) -> BiostructsymmetryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryPath::min(self : BiostructsymmetryPath) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryPath::max(self : BiostructsymmetryPath) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryPath::to_string(self : BiostructsymmetryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cluster_make(size : Int) -> BiostructsymmetryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryCluster::len(self : BiostructsymmetryCluster) -> Int { self.size }

pub fn BiostructsymmetryCluster::get(self : BiostructsymmetryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryCluster::set(self : BiostructsymmetryCluster, i : Int, v : Double) -> BiostructsymmetryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCluster::sum(self : BiostructsymmetryCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryCluster::mean(self : BiostructsymmetryCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryCluster::scale(self : BiostructsymmetryCluster, f : Double) -> BiostructsymmetryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCluster::add(self : BiostructsymmetryCluster, other : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryCluster::copy(self : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCluster::fill(self : BiostructsymmetryCluster, v : Double) -> BiostructsymmetryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCluster::min(self : BiostructsymmetryCluster) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryCluster::max(self : BiostructsymmetryCluster) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryCluster::to_string(self : BiostructsymmetryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_model_make(size : Int) -> BiostructsymmetryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryModel::len(self : BiostructsymmetryModel) -> Int { self.size }

pub fn BiostructsymmetryModel::get(self : BiostructsymmetryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryModel::set(self : BiostructsymmetryModel, i : Int, v : Double) -> BiostructsymmetryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryModel::sum(self : BiostructsymmetryModel) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryModel::mean(self : BiostructsymmetryModel) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryModel::scale(self : BiostructsymmetryModel, f : Double) -> BiostructsymmetryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryModel::add(self : BiostructsymmetryModel, other : BiostructsymmetryModel) -> BiostructsymmetryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryModel::copy(self : BiostructsymmetryModel) -> BiostructsymmetryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryModel::fill(self : BiostructsymmetryModel, v : Double) -> BiostructsymmetryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryModel::min(self : BiostructsymmetryModel) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryModel::max(self : BiostructsymmetryModel) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryModel::to_string(self : BiostructsymmetryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_layer_make(size : Int) -> BiostructsymmetryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryLayer::len(self : BiostructsymmetryLayer) -> Int { self.size }

pub fn BiostructsymmetryLayer::get(self : BiostructsymmetryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryLayer::set(self : BiostructsymmetryLayer, i : Int, v : Double) -> BiostructsymmetryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryLayer::sum(self : BiostructsymmetryLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryLayer::mean(self : BiostructsymmetryLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryLayer::scale(self : BiostructsymmetryLayer, f : Double) -> BiostructsymmetryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryLayer::add(self : BiostructsymmetryLayer, other : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryLayer::copy(self : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryLayer::fill(self : BiostructsymmetryLayer, v : Double) -> BiostructsymmetryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryLayer::min(self : BiostructsymmetryLayer) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryLayer::max(self : BiostructsymmetryLayer) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryLayer::to_string(self : BiostructsymmetryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_buffer_make(size : Int) -> BiostructsymmetryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryBuffer::len(self : BiostructsymmetryBuffer) -> Int { self.size }

pub fn BiostructsymmetryBuffer::get(self : BiostructsymmetryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryBuffer::set(self : BiostructsymmetryBuffer, i : Int, v : Double) -> BiostructsymmetryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryBuffer::sum(self : BiostructsymmetryBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryBuffer::mean(self : BiostructsymmetryBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryBuffer::scale(self : BiostructsymmetryBuffer, f : Double) -> BiostructsymmetryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryBuffer::add(self : BiostructsymmetryBuffer, other : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryBuffer::copy(self : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryBuffer::fill(self : BiostructsymmetryBuffer, v : Double) -> BiostructsymmetryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryBuffer::min(self : BiostructsymmetryBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryBuffer::max(self : BiostructsymmetryBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryBuffer::to_string(self : BiostructsymmetryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cursor_make(size : Int) -> BiostructsymmetryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryCursor::len(self : BiostructsymmetryCursor) -> Int { self.size }

pub fn BiostructsymmetryCursor::get(self : BiostructsymmetryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryCursor::set(self : BiostructsymmetryCursor, i : Int, v : Double) -> BiostructsymmetryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCursor::sum(self : BiostructsymmetryCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryCursor::mean(self : BiostructsymmetryCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryCursor::scale(self : BiostructsymmetryCursor, f : Double) -> BiostructsymmetryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCursor::add(self : BiostructsymmetryCursor, other : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryCursor::copy(self : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCursor::fill(self : BiostructsymmetryCursor, v : Double) -> BiostructsymmetryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryCursor::min(self : BiostructsymmetryCursor) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryCursor::max(self : BiostructsymmetryCursor) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryCursor::to_string(self : BiostructsymmetryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_view_make(size : Int) -> BiostructsymmetryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryView::len(self : BiostructsymmetryView) -> Int { self.size }

pub fn BiostructsymmetryView::get(self : BiostructsymmetryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryView::set(self : BiostructsymmetryView, i : Int, v : Double) -> BiostructsymmetryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryView::sum(self : BiostructsymmetryView) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryView::mean(self : BiostructsymmetryView) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryView::scale(self : BiostructsymmetryView, f : Double) -> BiostructsymmetryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryView::add(self : BiostructsymmetryView, other : BiostructsymmetryView) -> BiostructsymmetryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryView::copy(self : BiostructsymmetryView) -> BiostructsymmetryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryView::fill(self : BiostructsymmetryView, v : Double) -> BiostructsymmetryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryView::min(self : BiostructsymmetryView) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryView::max(self : BiostructsymmetryView) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryView::to_string(self : BiostructsymmetryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_range_make(size : Int) -> BiostructsymmetryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetryRange::len(self : BiostructsymmetryRange) -> Int { self.size }

pub fn BiostructsymmetryRange::get(self : BiostructsymmetryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetryRange::set(self : BiostructsymmetryRange, i : Int, v : Double) -> BiostructsymmetryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryRange::sum(self : BiostructsymmetryRange) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetryRange::mean(self : BiostructsymmetryRange) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetryRange::scale(self : BiostructsymmetryRange, f : Double) -> BiostructsymmetryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryRange::add(self : BiostructsymmetryRange, other : BiostructsymmetryRange) -> BiostructsymmetryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetryRange::copy(self : BiostructsymmetryRange) -> BiostructsymmetryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryRange::fill(self : BiostructsymmetryRange, v : Double) -> BiostructsymmetryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetryRange::min(self : BiostructsymmetryRange) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetryRange::max(self : BiostructsymmetryRange) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetryRange::to_string(self : BiostructsymmetryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetrySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_slice_make(size : Int) -> BiostructsymmetrySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsymmetrySlice::len(self : BiostructsymmetrySlice) -> Int { self.size }

pub fn BiostructsymmetrySlice::get(self : BiostructsymmetrySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsymmetrySlice::set(self : BiostructsymmetrySlice, i : Int, v : Double) -> BiostructsymmetrySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsymmetrySlice::sum(self : BiostructsymmetrySlice) -> Double { @_common.sum(self.data) }

pub fn BiostructsymmetrySlice::mean(self : BiostructsymmetrySlice) -> Double { @_common.mean(self.data) }

pub fn BiostructsymmetrySlice::scale(self : BiostructsymmetrySlice, f : Double) -> BiostructsymmetrySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetrySlice::add(self : BiostructsymmetrySlice, other : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsymmetrySlice::copy(self : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetrySlice::fill(self : BiostructsymmetrySlice, v : Double) -> BiostructsymmetrySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsymmetrySlice::min(self : BiostructsymmetrySlice) -> Double { @_common.min(self.data) }

pub fn BiostructsymmetrySlice::max(self : BiostructsymmetrySlice) -> Double { @_common.max(self.data) }

pub fn BiostructsymmetrySlice::to_string(self : BiostructsymmetrySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

