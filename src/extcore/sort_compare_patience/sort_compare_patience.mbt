///===
/// extcore/sort_compare_patience

pub(all) struct SortcomparepatiencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_patience_make_point(x : Double, y : Double) -> SortcomparepatiencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_patience_make_point3(x : Double, y : Double, z : Double) -> SortcomparepatiencePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparepatiencePoint::x(self : SortcomparepatiencePoint) -> Double { self.x }

pub fn SortcomparepatiencePoint::y(self : SortcomparepatiencePoint) -> Double { self.y }

pub fn SortcomparepatiencePoint::z(self : SortcomparepatiencePoint) -> Double { self.z }

pub fn SortcomparepatiencePoint::label(self : SortcomparepatiencePoint) -> Int { self.label }

pub fn SortcomparepatiencePoint::dist(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparepatiencePoint::add(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparepatiencePoint::sub(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparepatiencePoint::scale(self : SortcomparepatiencePoint, s : Double) -> SortcomparepatiencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparepatiencePoint::dot(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparepatiencePoint::cross(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparepatiencePoint::norm(self : SortcomparepatiencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparepatiencePoint::normalize(self : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparepatiencePoint::negate(self : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparepatiencePoint::mid(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparepatiencePoint::lerp(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint, t : Double) -> SortcomparepatiencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparepatiencePoint::to_string(self : SortcomparepatiencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparepatienceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_patience_make_series(vals : Array[Double], name : String) -> SortcomparepatienceSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparepatienceSeries::len(self : SortcomparepatienceSeries) -> Int { self.vals.length() }

pub fn SortcomparepatienceSeries::sum(self : SortcomparepatienceSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparepatienceSeries::mean(self : SortcomparepatienceSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparepatienceSeries::min(self : SortcomparepatienceSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparepatienceSeries::max(self : SortcomparepatienceSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparepatienceSeries::range(self : SortcomparepatienceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparepatienceSeries::variance(self : SortcomparepatienceSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparepatienceSeries::std(self : SortcomparepatienceSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparepatienceSeries::median(self : SortcomparepatienceSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparepatienceSeries::scale(self : SortcomparepatienceSeries, f : Double) -> SortcomparepatienceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::add(self : SortcomparepatienceSeries, other : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::sub(self : SortcomparepatienceSeries, other : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::normalize(self : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparepatienceSeries::cumsum(self : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparepatienceSeries::to_string(self : SortcomparepatienceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparepatienceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_patience_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparepatienceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_patience_matrix_identity(n : Int) -> SortcomparepatienceMatrix {
  let m = sort_compare_patience_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparepatienceMatrix::get(self : SortcomparepatienceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparepatienceMatrix::transpose(self : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparepatienceMatrix::add(self : SortcomparepatienceMatrix, other : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_patience_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparepatienceMatrix::scale(self : SortcomparepatienceMatrix, s : Double) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparepatienceMatrix::multiply(self : SortcomparepatienceMatrix, other : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if self.cols != other.rows { return sort_compare_patience_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_patience_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparepatienceMatrix::trace(self : SortcomparepatienceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparepatienceMatrix::det(self : SortcomparepatienceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparepatienceMatrix::norm(self : SortcomparepatienceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparepatienceMatrix::to_string(self : SortcomparepatienceMatrix) -> String {
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

pub(all) struct SortcomparepatienceVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_patience_make_vector(comps : Array[Double]) -> SortcomparepatienceVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_patience_vector_zero(dim : Int) -> SortcomparepatienceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparepatienceVector::add(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparepatienceVector::sub(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparepatienceVector::scale(self : SortcomparepatienceVector, s : Double) -> SortcomparepatienceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparepatienceVector::dot(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparepatienceVector::norm(self : SortcomparepatienceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparepatienceVector::normalize(self : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparepatienceVector::dist(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparepatienceVector::to_string(self : SortcomparepatienceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_patience_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_patience_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_patience_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_patience_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_patience_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_patience_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_patience_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_patience_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_patience_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_patience_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_patience_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_patience_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_patience_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_patience_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_patience_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_patience_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_patience_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_patience_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_patience_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_patience_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_patience_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_patience_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_patience_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_patience_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_patience_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_patience_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_patience_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_patience_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_patience_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparepatienceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_frame_make(size : Int) -> SortcomparepatienceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceFrame::len(self : SortcomparepatienceFrame) -> Int { self.size }

pub fn SortcomparepatienceFrame::get(self : SortcomparepatienceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceFrame::set(self : SortcomparepatienceFrame, i : Int, v : Double) -> SortcomparepatienceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceFrame::sum(self : SortcomparepatienceFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceFrame::mean(self : SortcomparepatienceFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceFrame::scale(self : SortcomparepatienceFrame, f : Double) -> SortcomparepatienceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceFrame::add(self : SortcomparepatienceFrame, other : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceFrame::copy(self : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceFrame::fill(self : SortcomparepatienceFrame, v : Double) -> SortcomparepatienceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceFrame::min(self : SortcomparepatienceFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceFrame::max(self : SortcomparepatienceFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceFrame::to_string(self : SortcomparepatienceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_table_make(size : Int) -> SortcomparepatienceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceTable::len(self : SortcomparepatienceTable) -> Int { self.size }

pub fn SortcomparepatienceTable::get(self : SortcomparepatienceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceTable::set(self : SortcomparepatienceTable, i : Int, v : Double) -> SortcomparepatienceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceTable::sum(self : SortcomparepatienceTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceTable::mean(self : SortcomparepatienceTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceTable::scale(self : SortcomparepatienceTable, f : Double) -> SortcomparepatienceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceTable::add(self : SortcomparepatienceTable, other : SortcomparepatienceTable) -> SortcomparepatienceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceTable::copy(self : SortcomparepatienceTable) -> SortcomparepatienceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceTable::fill(self : SortcomparepatienceTable, v : Double) -> SortcomparepatienceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceTable::min(self : SortcomparepatienceTable) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceTable::max(self : SortcomparepatienceTable) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceTable::to_string(self : SortcomparepatienceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_graphn_make(size : Int) -> SortcomparepatienceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceGraphN::len(self : SortcomparepatienceGraphN) -> Int { self.size }

pub fn SortcomparepatienceGraphN::get(self : SortcomparepatienceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceGraphN::set(self : SortcomparepatienceGraphN, i : Int, v : Double) -> SortcomparepatienceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceGraphN::sum(self : SortcomparepatienceGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceGraphN::mean(self : SortcomparepatienceGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceGraphN::scale(self : SortcomparepatienceGraphN, f : Double) -> SortcomparepatienceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceGraphN::add(self : SortcomparepatienceGraphN, other : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceGraphN::copy(self : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceGraphN::fill(self : SortcomparepatienceGraphN, v : Double) -> SortcomparepatienceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceGraphN::min(self : SortcomparepatienceGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceGraphN::max(self : SortcomparepatienceGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceGraphN::to_string(self : SortcomparepatienceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_node_make(size : Int) -> SortcomparepatienceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceNode::len(self : SortcomparepatienceNode) -> Int { self.size }

pub fn SortcomparepatienceNode::get(self : SortcomparepatienceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceNode::set(self : SortcomparepatienceNode, i : Int, v : Double) -> SortcomparepatienceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceNode::sum(self : SortcomparepatienceNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceNode::mean(self : SortcomparepatienceNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceNode::scale(self : SortcomparepatienceNode, f : Double) -> SortcomparepatienceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceNode::add(self : SortcomparepatienceNode, other : SortcomparepatienceNode) -> SortcomparepatienceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceNode::copy(self : SortcomparepatienceNode) -> SortcomparepatienceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceNode::fill(self : SortcomparepatienceNode, v : Double) -> SortcomparepatienceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceNode::min(self : SortcomparepatienceNode) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceNode::max(self : SortcomparepatienceNode) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceNode::to_string(self : SortcomparepatienceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_edge_make(size : Int) -> SortcomparepatienceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceEdge::len(self : SortcomparepatienceEdge) -> Int { self.size }

pub fn SortcomparepatienceEdge::get(self : SortcomparepatienceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceEdge::set(self : SortcomparepatienceEdge, i : Int, v : Double) -> SortcomparepatienceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceEdge::sum(self : SortcomparepatienceEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceEdge::mean(self : SortcomparepatienceEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceEdge::scale(self : SortcomparepatienceEdge, f : Double) -> SortcomparepatienceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceEdge::add(self : SortcomparepatienceEdge, other : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceEdge::copy(self : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceEdge::fill(self : SortcomparepatienceEdge, v : Double) -> SortcomparepatienceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceEdge::min(self : SortcomparepatienceEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceEdge::max(self : SortcomparepatienceEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceEdge::to_string(self : SortcomparepatienceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatiencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_path_make(size : Int) -> SortcomparepatiencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatiencePath::len(self : SortcomparepatiencePath) -> Int { self.size }

pub fn SortcomparepatiencePath::get(self : SortcomparepatiencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatiencePath::set(self : SortcomparepatiencePath, i : Int, v : Double) -> SortcomparepatiencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatiencePath::sum(self : SortcomparepatiencePath) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatiencePath::mean(self : SortcomparepatiencePath) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatiencePath::scale(self : SortcomparepatiencePath, f : Double) -> SortcomparepatiencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatiencePath::add(self : SortcomparepatiencePath, other : SortcomparepatiencePath) -> SortcomparepatiencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatiencePath::copy(self : SortcomparepatiencePath) -> SortcomparepatiencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatiencePath::fill(self : SortcomparepatiencePath, v : Double) -> SortcomparepatiencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatiencePath::min(self : SortcomparepatiencePath) -> Double { @_common.min(self.data) }

pub fn SortcomparepatiencePath::max(self : SortcomparepatiencePath) -> Double { @_common.max(self.data) }

pub fn SortcomparepatiencePath::to_string(self : SortcomparepatiencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cluster_make(size : Int) -> SortcomparepatienceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceCluster::len(self : SortcomparepatienceCluster) -> Int { self.size }

pub fn SortcomparepatienceCluster::get(self : SortcomparepatienceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceCluster::set(self : SortcomparepatienceCluster, i : Int, v : Double) -> SortcomparepatienceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCluster::sum(self : SortcomparepatienceCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceCluster::mean(self : SortcomparepatienceCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceCluster::scale(self : SortcomparepatienceCluster, f : Double) -> SortcomparepatienceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCluster::add(self : SortcomparepatienceCluster, other : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceCluster::copy(self : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCluster::fill(self : SortcomparepatienceCluster, v : Double) -> SortcomparepatienceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCluster::min(self : SortcomparepatienceCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceCluster::max(self : SortcomparepatienceCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceCluster::to_string(self : SortcomparepatienceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_model_make(size : Int) -> SortcomparepatienceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceModel::len(self : SortcomparepatienceModel) -> Int { self.size }

pub fn SortcomparepatienceModel::get(self : SortcomparepatienceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceModel::set(self : SortcomparepatienceModel, i : Int, v : Double) -> SortcomparepatienceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceModel::sum(self : SortcomparepatienceModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceModel::mean(self : SortcomparepatienceModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceModel::scale(self : SortcomparepatienceModel, f : Double) -> SortcomparepatienceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceModel::add(self : SortcomparepatienceModel, other : SortcomparepatienceModel) -> SortcomparepatienceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceModel::copy(self : SortcomparepatienceModel) -> SortcomparepatienceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceModel::fill(self : SortcomparepatienceModel, v : Double) -> SortcomparepatienceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceModel::min(self : SortcomparepatienceModel) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceModel::max(self : SortcomparepatienceModel) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceModel::to_string(self : SortcomparepatienceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_layer_make(size : Int) -> SortcomparepatienceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceLayer::len(self : SortcomparepatienceLayer) -> Int { self.size }

pub fn SortcomparepatienceLayer::get(self : SortcomparepatienceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceLayer::set(self : SortcomparepatienceLayer, i : Int, v : Double) -> SortcomparepatienceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceLayer::sum(self : SortcomparepatienceLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceLayer::mean(self : SortcomparepatienceLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceLayer::scale(self : SortcomparepatienceLayer, f : Double) -> SortcomparepatienceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceLayer::add(self : SortcomparepatienceLayer, other : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceLayer::copy(self : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceLayer::fill(self : SortcomparepatienceLayer, v : Double) -> SortcomparepatienceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceLayer::min(self : SortcomparepatienceLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceLayer::max(self : SortcomparepatienceLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceLayer::to_string(self : SortcomparepatienceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_buffer_make(size : Int) -> SortcomparepatienceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceBuffer::len(self : SortcomparepatienceBuffer) -> Int { self.size }

pub fn SortcomparepatienceBuffer::get(self : SortcomparepatienceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceBuffer::set(self : SortcomparepatienceBuffer, i : Int, v : Double) -> SortcomparepatienceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceBuffer::sum(self : SortcomparepatienceBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceBuffer::mean(self : SortcomparepatienceBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceBuffer::scale(self : SortcomparepatienceBuffer, f : Double) -> SortcomparepatienceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceBuffer::add(self : SortcomparepatienceBuffer, other : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceBuffer::copy(self : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceBuffer::fill(self : SortcomparepatienceBuffer, v : Double) -> SortcomparepatienceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceBuffer::min(self : SortcomparepatienceBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceBuffer::max(self : SortcomparepatienceBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceBuffer::to_string(self : SortcomparepatienceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cursor_make(size : Int) -> SortcomparepatienceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceCursor::len(self : SortcomparepatienceCursor) -> Int { self.size }

pub fn SortcomparepatienceCursor::get(self : SortcomparepatienceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceCursor::set(self : SortcomparepatienceCursor, i : Int, v : Double) -> SortcomparepatienceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCursor::sum(self : SortcomparepatienceCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceCursor::mean(self : SortcomparepatienceCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceCursor::scale(self : SortcomparepatienceCursor, f : Double) -> SortcomparepatienceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCursor::add(self : SortcomparepatienceCursor, other : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceCursor::copy(self : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCursor::fill(self : SortcomparepatienceCursor, v : Double) -> SortcomparepatienceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceCursor::min(self : SortcomparepatienceCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceCursor::max(self : SortcomparepatienceCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceCursor::to_string(self : SortcomparepatienceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_view_make(size : Int) -> SortcomparepatienceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceView::len(self : SortcomparepatienceView) -> Int { self.size }

pub fn SortcomparepatienceView::get(self : SortcomparepatienceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceView::set(self : SortcomparepatienceView, i : Int, v : Double) -> SortcomparepatienceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceView::sum(self : SortcomparepatienceView) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceView::mean(self : SortcomparepatienceView) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceView::scale(self : SortcomparepatienceView, f : Double) -> SortcomparepatienceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceView::add(self : SortcomparepatienceView, other : SortcomparepatienceView) -> SortcomparepatienceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceView::copy(self : SortcomparepatienceView) -> SortcomparepatienceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceView::fill(self : SortcomparepatienceView, v : Double) -> SortcomparepatienceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceView::min(self : SortcomparepatienceView) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceView::max(self : SortcomparepatienceView) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceView::to_string(self : SortcomparepatienceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_range_make(size : Int) -> SortcomparepatienceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceRange::len(self : SortcomparepatienceRange) -> Int { self.size }

pub fn SortcomparepatienceRange::get(self : SortcomparepatienceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceRange::set(self : SortcomparepatienceRange, i : Int, v : Double) -> SortcomparepatienceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceRange::sum(self : SortcomparepatienceRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceRange::mean(self : SortcomparepatienceRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceRange::scale(self : SortcomparepatienceRange, f : Double) -> SortcomparepatienceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceRange::add(self : SortcomparepatienceRange, other : SortcomparepatienceRange) -> SortcomparepatienceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceRange::copy(self : SortcomparepatienceRange) -> SortcomparepatienceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceRange::fill(self : SortcomparepatienceRange, v : Double) -> SortcomparepatienceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceRange::min(self : SortcomparepatienceRange) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceRange::max(self : SortcomparepatienceRange) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceRange::to_string(self : SortcomparepatienceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_slice_make(size : Int) -> SortcomparepatienceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparepatienceSlice::len(self : SortcomparepatienceSlice) -> Int { self.size }

pub fn SortcomparepatienceSlice::get(self : SortcomparepatienceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparepatienceSlice::set(self : SortcomparepatienceSlice, i : Int, v : Double) -> SortcomparepatienceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceSlice::sum(self : SortcomparepatienceSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparepatienceSlice::mean(self : SortcomparepatienceSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparepatienceSlice::scale(self : SortcomparepatienceSlice, f : Double) -> SortcomparepatienceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceSlice::add(self : SortcomparepatienceSlice, other : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparepatienceSlice::copy(self : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceSlice::fill(self : SortcomparepatienceSlice, v : Double) -> SortcomparepatienceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparepatienceSlice::min(self : SortcomparepatienceSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparepatienceSlice::max(self : SortcomparepatienceSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparepatienceSlice::to_string(self : SortcomparepatienceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

