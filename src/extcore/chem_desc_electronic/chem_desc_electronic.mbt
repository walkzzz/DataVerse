///===
/// extcore/chem_desc_electronic

pub(all) struct ChemdescelectronicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_electronic_make_point(x : Double, y : Double) -> ChemdescelectronicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_electronic_make_point3(x : Double, y : Double, z : Double) -> ChemdescelectronicPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescelectronicPoint::x(self : ChemdescelectronicPoint) -> Double { self.x }

pub fn ChemdescelectronicPoint::y(self : ChemdescelectronicPoint) -> Double { self.y }

pub fn ChemdescelectronicPoint::z(self : ChemdescelectronicPoint) -> Double { self.z }

pub fn ChemdescelectronicPoint::label(self : ChemdescelectronicPoint) -> Int { self.label }

pub fn ChemdescelectronicPoint::dist(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescelectronicPoint::add(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescelectronicPoint::sub(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescelectronicPoint::scale(self : ChemdescelectronicPoint, s : Double) -> ChemdescelectronicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescelectronicPoint::dot(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescelectronicPoint::cross(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescelectronicPoint::norm(self : ChemdescelectronicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescelectronicPoint::normalize(self : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescelectronicPoint::negate(self : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescelectronicPoint::mid(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescelectronicPoint::lerp(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint, t : Double) -> ChemdescelectronicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescelectronicPoint::to_string(self : ChemdescelectronicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescelectronicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_electronic_make_series(vals : Array[Double], name : String) -> ChemdescelectronicSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescelectronicSeries::len(self : ChemdescelectronicSeries) -> Int { self.vals.length() }

pub fn ChemdescelectronicSeries::sum(self : ChemdescelectronicSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescelectronicSeries::mean(self : ChemdescelectronicSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescelectronicSeries::min(self : ChemdescelectronicSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescelectronicSeries::max(self : ChemdescelectronicSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescelectronicSeries::range(self : ChemdescelectronicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescelectronicSeries::variance(self : ChemdescelectronicSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescelectronicSeries::std(self : ChemdescelectronicSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescelectronicSeries::median(self : ChemdescelectronicSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescelectronicSeries::scale(self : ChemdescelectronicSeries, f : Double) -> ChemdescelectronicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::add(self : ChemdescelectronicSeries, other : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::sub(self : ChemdescelectronicSeries, other : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::normalize(self : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescelectronicSeries::cumsum(self : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescelectronicSeries::to_string(self : ChemdescelectronicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescelectronicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_electronic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescelectronicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_electronic_matrix_identity(n : Int) -> ChemdescelectronicMatrix {
  let m = chem_desc_electronic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescelectronicMatrix::get(self : ChemdescelectronicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescelectronicMatrix::transpose(self : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescelectronicMatrix::add(self : ChemdescelectronicMatrix, other : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_electronic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescelectronicMatrix::scale(self : ChemdescelectronicMatrix, s : Double) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescelectronicMatrix::multiply(self : ChemdescelectronicMatrix, other : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if self.cols != other.rows { return chem_desc_electronic_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_electronic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescelectronicMatrix::trace(self : ChemdescelectronicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescelectronicMatrix::det(self : ChemdescelectronicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescelectronicMatrix::norm(self : ChemdescelectronicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescelectronicMatrix::to_string(self : ChemdescelectronicMatrix) -> String {
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

pub(all) struct ChemdescelectronicVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_electronic_make_vector(comps : Array[Double]) -> ChemdescelectronicVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_electronic_vector_zero(dim : Int) -> ChemdescelectronicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescelectronicVector::add(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescelectronicVector::sub(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescelectronicVector::scale(self : ChemdescelectronicVector, s : Double) -> ChemdescelectronicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescelectronicVector::dot(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescelectronicVector::norm(self : ChemdescelectronicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescelectronicVector::normalize(self : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescelectronicVector::dist(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescelectronicVector::to_string(self : ChemdescelectronicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_electronic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_electronic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_electronic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_electronic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_electronic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_electronic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_electronic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_electronic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_electronic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_electronic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_electronic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_electronic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_electronic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_electronic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_electronic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_electronic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_electronic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_electronic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_electronic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_electronic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_electronic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_electronic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_electronic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_electronic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_electronic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_electronic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_electronic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_electronic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_electronic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescelectronicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_frame_make(size : Int) -> ChemdescelectronicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicFrame::len(self : ChemdescelectronicFrame) -> Int { self.size }

pub fn ChemdescelectronicFrame::get(self : ChemdescelectronicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicFrame::set(self : ChemdescelectronicFrame, i : Int, v : Double) -> ChemdescelectronicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicFrame::sum(self : ChemdescelectronicFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicFrame::mean(self : ChemdescelectronicFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicFrame::scale(self : ChemdescelectronicFrame, f : Double) -> ChemdescelectronicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicFrame::add(self : ChemdescelectronicFrame, other : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicFrame::copy(self : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicFrame::fill(self : ChemdescelectronicFrame, v : Double) -> ChemdescelectronicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicFrame::min(self : ChemdescelectronicFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicFrame::max(self : ChemdescelectronicFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicFrame::to_string(self : ChemdescelectronicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_table_make(size : Int) -> ChemdescelectronicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicTable::len(self : ChemdescelectronicTable) -> Int { self.size }

pub fn ChemdescelectronicTable::get(self : ChemdescelectronicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicTable::set(self : ChemdescelectronicTable, i : Int, v : Double) -> ChemdescelectronicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicTable::sum(self : ChemdescelectronicTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicTable::mean(self : ChemdescelectronicTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicTable::scale(self : ChemdescelectronicTable, f : Double) -> ChemdescelectronicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicTable::add(self : ChemdescelectronicTable, other : ChemdescelectronicTable) -> ChemdescelectronicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicTable::copy(self : ChemdescelectronicTable) -> ChemdescelectronicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicTable::fill(self : ChemdescelectronicTable, v : Double) -> ChemdescelectronicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicTable::min(self : ChemdescelectronicTable) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicTable::max(self : ChemdescelectronicTable) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicTable::to_string(self : ChemdescelectronicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_graphn_make(size : Int) -> ChemdescelectronicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicGraphN::len(self : ChemdescelectronicGraphN) -> Int { self.size }

pub fn ChemdescelectronicGraphN::get(self : ChemdescelectronicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicGraphN::set(self : ChemdescelectronicGraphN, i : Int, v : Double) -> ChemdescelectronicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicGraphN::sum(self : ChemdescelectronicGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicGraphN::mean(self : ChemdescelectronicGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicGraphN::scale(self : ChemdescelectronicGraphN, f : Double) -> ChemdescelectronicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicGraphN::add(self : ChemdescelectronicGraphN, other : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicGraphN::copy(self : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicGraphN::fill(self : ChemdescelectronicGraphN, v : Double) -> ChemdescelectronicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicGraphN::min(self : ChemdescelectronicGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicGraphN::max(self : ChemdescelectronicGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicGraphN::to_string(self : ChemdescelectronicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_node_make(size : Int) -> ChemdescelectronicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicNode::len(self : ChemdescelectronicNode) -> Int { self.size }

pub fn ChemdescelectronicNode::get(self : ChemdescelectronicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicNode::set(self : ChemdescelectronicNode, i : Int, v : Double) -> ChemdescelectronicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicNode::sum(self : ChemdescelectronicNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicNode::mean(self : ChemdescelectronicNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicNode::scale(self : ChemdescelectronicNode, f : Double) -> ChemdescelectronicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicNode::add(self : ChemdescelectronicNode, other : ChemdescelectronicNode) -> ChemdescelectronicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicNode::copy(self : ChemdescelectronicNode) -> ChemdescelectronicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicNode::fill(self : ChemdescelectronicNode, v : Double) -> ChemdescelectronicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicNode::min(self : ChemdescelectronicNode) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicNode::max(self : ChemdescelectronicNode) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicNode::to_string(self : ChemdescelectronicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_edge_make(size : Int) -> ChemdescelectronicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicEdge::len(self : ChemdescelectronicEdge) -> Int { self.size }

pub fn ChemdescelectronicEdge::get(self : ChemdescelectronicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicEdge::set(self : ChemdescelectronicEdge, i : Int, v : Double) -> ChemdescelectronicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicEdge::sum(self : ChemdescelectronicEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicEdge::mean(self : ChemdescelectronicEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicEdge::scale(self : ChemdescelectronicEdge, f : Double) -> ChemdescelectronicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicEdge::add(self : ChemdescelectronicEdge, other : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicEdge::copy(self : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicEdge::fill(self : ChemdescelectronicEdge, v : Double) -> ChemdescelectronicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicEdge::min(self : ChemdescelectronicEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicEdge::max(self : ChemdescelectronicEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicEdge::to_string(self : ChemdescelectronicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_path_make(size : Int) -> ChemdescelectronicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicPath::len(self : ChemdescelectronicPath) -> Int { self.size }

pub fn ChemdescelectronicPath::get(self : ChemdescelectronicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicPath::set(self : ChemdescelectronicPath, i : Int, v : Double) -> ChemdescelectronicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicPath::sum(self : ChemdescelectronicPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicPath::mean(self : ChemdescelectronicPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicPath::scale(self : ChemdescelectronicPath, f : Double) -> ChemdescelectronicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicPath::add(self : ChemdescelectronicPath, other : ChemdescelectronicPath) -> ChemdescelectronicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicPath::copy(self : ChemdescelectronicPath) -> ChemdescelectronicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicPath::fill(self : ChemdescelectronicPath, v : Double) -> ChemdescelectronicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicPath::min(self : ChemdescelectronicPath) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicPath::max(self : ChemdescelectronicPath) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicPath::to_string(self : ChemdescelectronicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cluster_make(size : Int) -> ChemdescelectronicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicCluster::len(self : ChemdescelectronicCluster) -> Int { self.size }

pub fn ChemdescelectronicCluster::get(self : ChemdescelectronicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicCluster::set(self : ChemdescelectronicCluster, i : Int, v : Double) -> ChemdescelectronicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCluster::sum(self : ChemdescelectronicCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicCluster::mean(self : ChemdescelectronicCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicCluster::scale(self : ChemdescelectronicCluster, f : Double) -> ChemdescelectronicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCluster::add(self : ChemdescelectronicCluster, other : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicCluster::copy(self : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCluster::fill(self : ChemdescelectronicCluster, v : Double) -> ChemdescelectronicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCluster::min(self : ChemdescelectronicCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicCluster::max(self : ChemdescelectronicCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicCluster::to_string(self : ChemdescelectronicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_model_make(size : Int) -> ChemdescelectronicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicModel::len(self : ChemdescelectronicModel) -> Int { self.size }

pub fn ChemdescelectronicModel::get(self : ChemdescelectronicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicModel::set(self : ChemdescelectronicModel, i : Int, v : Double) -> ChemdescelectronicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicModel::sum(self : ChemdescelectronicModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicModel::mean(self : ChemdescelectronicModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicModel::scale(self : ChemdescelectronicModel, f : Double) -> ChemdescelectronicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicModel::add(self : ChemdescelectronicModel, other : ChemdescelectronicModel) -> ChemdescelectronicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicModel::copy(self : ChemdescelectronicModel) -> ChemdescelectronicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicModel::fill(self : ChemdescelectronicModel, v : Double) -> ChemdescelectronicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicModel::min(self : ChemdescelectronicModel) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicModel::max(self : ChemdescelectronicModel) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicModel::to_string(self : ChemdescelectronicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_layer_make(size : Int) -> ChemdescelectronicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicLayer::len(self : ChemdescelectronicLayer) -> Int { self.size }

pub fn ChemdescelectronicLayer::get(self : ChemdescelectronicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicLayer::set(self : ChemdescelectronicLayer, i : Int, v : Double) -> ChemdescelectronicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicLayer::sum(self : ChemdescelectronicLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicLayer::mean(self : ChemdescelectronicLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicLayer::scale(self : ChemdescelectronicLayer, f : Double) -> ChemdescelectronicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicLayer::add(self : ChemdescelectronicLayer, other : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicLayer::copy(self : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicLayer::fill(self : ChemdescelectronicLayer, v : Double) -> ChemdescelectronicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicLayer::min(self : ChemdescelectronicLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicLayer::max(self : ChemdescelectronicLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicLayer::to_string(self : ChemdescelectronicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_buffer_make(size : Int) -> ChemdescelectronicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicBuffer::len(self : ChemdescelectronicBuffer) -> Int { self.size }

pub fn ChemdescelectronicBuffer::get(self : ChemdescelectronicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicBuffer::set(self : ChemdescelectronicBuffer, i : Int, v : Double) -> ChemdescelectronicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicBuffer::sum(self : ChemdescelectronicBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicBuffer::mean(self : ChemdescelectronicBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicBuffer::scale(self : ChemdescelectronicBuffer, f : Double) -> ChemdescelectronicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicBuffer::add(self : ChemdescelectronicBuffer, other : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicBuffer::copy(self : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicBuffer::fill(self : ChemdescelectronicBuffer, v : Double) -> ChemdescelectronicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicBuffer::min(self : ChemdescelectronicBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicBuffer::max(self : ChemdescelectronicBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicBuffer::to_string(self : ChemdescelectronicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cursor_make(size : Int) -> ChemdescelectronicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicCursor::len(self : ChemdescelectronicCursor) -> Int { self.size }

pub fn ChemdescelectronicCursor::get(self : ChemdescelectronicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicCursor::set(self : ChemdescelectronicCursor, i : Int, v : Double) -> ChemdescelectronicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCursor::sum(self : ChemdescelectronicCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicCursor::mean(self : ChemdescelectronicCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicCursor::scale(self : ChemdescelectronicCursor, f : Double) -> ChemdescelectronicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCursor::add(self : ChemdescelectronicCursor, other : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicCursor::copy(self : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCursor::fill(self : ChemdescelectronicCursor, v : Double) -> ChemdescelectronicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicCursor::min(self : ChemdescelectronicCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicCursor::max(self : ChemdescelectronicCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicCursor::to_string(self : ChemdescelectronicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_view_make(size : Int) -> ChemdescelectronicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicView::len(self : ChemdescelectronicView) -> Int { self.size }

pub fn ChemdescelectronicView::get(self : ChemdescelectronicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicView::set(self : ChemdescelectronicView, i : Int, v : Double) -> ChemdescelectronicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicView::sum(self : ChemdescelectronicView) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicView::mean(self : ChemdescelectronicView) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicView::scale(self : ChemdescelectronicView, f : Double) -> ChemdescelectronicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicView::add(self : ChemdescelectronicView, other : ChemdescelectronicView) -> ChemdescelectronicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicView::copy(self : ChemdescelectronicView) -> ChemdescelectronicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicView::fill(self : ChemdescelectronicView, v : Double) -> ChemdescelectronicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicView::min(self : ChemdescelectronicView) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicView::max(self : ChemdescelectronicView) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicView::to_string(self : ChemdescelectronicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_range_make(size : Int) -> ChemdescelectronicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicRange::len(self : ChemdescelectronicRange) -> Int { self.size }

pub fn ChemdescelectronicRange::get(self : ChemdescelectronicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicRange::set(self : ChemdescelectronicRange, i : Int, v : Double) -> ChemdescelectronicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicRange::sum(self : ChemdescelectronicRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicRange::mean(self : ChemdescelectronicRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicRange::scale(self : ChemdescelectronicRange, f : Double) -> ChemdescelectronicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicRange::add(self : ChemdescelectronicRange, other : ChemdescelectronicRange) -> ChemdescelectronicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicRange::copy(self : ChemdescelectronicRange) -> ChemdescelectronicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicRange::fill(self : ChemdescelectronicRange, v : Double) -> ChemdescelectronicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicRange::min(self : ChemdescelectronicRange) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicRange::max(self : ChemdescelectronicRange) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicRange::to_string(self : ChemdescelectronicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_slice_make(size : Int) -> ChemdescelectronicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescelectronicSlice::len(self : ChemdescelectronicSlice) -> Int { self.size }

pub fn ChemdescelectronicSlice::get(self : ChemdescelectronicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescelectronicSlice::set(self : ChemdescelectronicSlice, i : Int, v : Double) -> ChemdescelectronicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicSlice::sum(self : ChemdescelectronicSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescelectronicSlice::mean(self : ChemdescelectronicSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescelectronicSlice::scale(self : ChemdescelectronicSlice, f : Double) -> ChemdescelectronicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicSlice::add(self : ChemdescelectronicSlice, other : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescelectronicSlice::copy(self : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicSlice::fill(self : ChemdescelectronicSlice, v : Double) -> ChemdescelectronicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescelectronicSlice::min(self : ChemdescelectronicSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescelectronicSlice::max(self : ChemdescelectronicSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescelectronicSlice::to_string(self : ChemdescelectronicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

