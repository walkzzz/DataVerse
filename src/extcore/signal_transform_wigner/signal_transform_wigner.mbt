///===
/// extcore/signal_transform_wigner

pub(all) struct SignaltransformwignerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_wigner_make_point(x : Double, y : Double) -> SignaltransformwignerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_wigner_make_point3(x : Double, y : Double, z : Double) -> SignaltransformwignerPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformwignerPoint::x(self : SignaltransformwignerPoint) -> Double { self.x }

pub fn SignaltransformwignerPoint::y(self : SignaltransformwignerPoint) -> Double { self.y }

pub fn SignaltransformwignerPoint::z(self : SignaltransformwignerPoint) -> Double { self.z }

pub fn SignaltransformwignerPoint::label(self : SignaltransformwignerPoint) -> Int { self.label }

pub fn SignaltransformwignerPoint::dist(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformwignerPoint::add(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformwignerPoint::sub(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformwignerPoint::scale(self : SignaltransformwignerPoint, s : Double) -> SignaltransformwignerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformwignerPoint::dot(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformwignerPoint::cross(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformwignerPoint::norm(self : SignaltransformwignerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformwignerPoint::normalize(self : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformwignerPoint::negate(self : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformwignerPoint::mid(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformwignerPoint::lerp(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint, t : Double) -> SignaltransformwignerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformwignerPoint::to_string(self : SignaltransformwignerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformwignerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_wigner_make_series(vals : Array[Double], name : String) -> SignaltransformwignerSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformwignerSeries::len(self : SignaltransformwignerSeries) -> Int { self.vals.length() }

pub fn SignaltransformwignerSeries::sum(self : SignaltransformwignerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformwignerSeries::mean(self : SignaltransformwignerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformwignerSeries::min(self : SignaltransformwignerSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformwignerSeries::max(self : SignaltransformwignerSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformwignerSeries::range(self : SignaltransformwignerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformwignerSeries::variance(self : SignaltransformwignerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformwignerSeries::std(self : SignaltransformwignerSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformwignerSeries::median(self : SignaltransformwignerSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformwignerSeries::scale(self : SignaltransformwignerSeries, f : Double) -> SignaltransformwignerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::add(self : SignaltransformwignerSeries, other : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::sub(self : SignaltransformwignerSeries, other : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::normalize(self : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformwignerSeries::cumsum(self : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformwignerSeries::to_string(self : SignaltransformwignerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformwignerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_wigner_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformwignerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_wigner_matrix_identity(n : Int) -> SignaltransformwignerMatrix {
  let m = signal_transform_wigner_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformwignerMatrix::get(self : SignaltransformwignerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformwignerMatrix::transpose(self : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformwignerMatrix::add(self : SignaltransformwignerMatrix, other : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_wigner_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformwignerMatrix::scale(self : SignaltransformwignerMatrix, s : Double) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformwignerMatrix::multiply(self : SignaltransformwignerMatrix, other : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if self.cols != other.rows { return signal_transform_wigner_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_wigner_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformwignerMatrix::trace(self : SignaltransformwignerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformwignerMatrix::det(self : SignaltransformwignerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformwignerMatrix::norm(self : SignaltransformwignerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformwignerMatrix::to_string(self : SignaltransformwignerMatrix) -> String {
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

pub(all) struct SignaltransformwignerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_wigner_make_vector(comps : Array[Double]) -> SignaltransformwignerVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_wigner_vector_zero(dim : Int) -> SignaltransformwignerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformwignerVector::add(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformwignerVector::sub(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformwignerVector::scale(self : SignaltransformwignerVector, s : Double) -> SignaltransformwignerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformwignerVector::dot(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformwignerVector::norm(self : SignaltransformwignerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformwignerVector::normalize(self : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformwignerVector::dist(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformwignerVector::to_string(self : SignaltransformwignerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_wigner_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_wigner_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_wigner_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_wigner_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_wigner_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_wigner_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_wigner_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_wigner_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_wigner_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_wigner_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_wigner_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_wigner_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_wigner_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_wigner_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_wigner_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_wigner_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_wigner_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_wigner_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_wigner_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_wigner_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_wigner_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_wigner_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_wigner_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_wigner_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_wigner_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_wigner_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_wigner_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_wigner_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_wigner_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformwignerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_frame_make(size : Int) -> SignaltransformwignerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerFrame::len(self : SignaltransformwignerFrame) -> Int { self.size }

pub fn SignaltransformwignerFrame::get(self : SignaltransformwignerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerFrame::set(self : SignaltransformwignerFrame, i : Int, v : Double) -> SignaltransformwignerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerFrame::sum(self : SignaltransformwignerFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerFrame::mean(self : SignaltransformwignerFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerFrame::scale(self : SignaltransformwignerFrame, f : Double) -> SignaltransformwignerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerFrame::add(self : SignaltransformwignerFrame, other : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerFrame::copy(self : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerFrame::fill(self : SignaltransformwignerFrame, v : Double) -> SignaltransformwignerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerFrame::min(self : SignaltransformwignerFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerFrame::max(self : SignaltransformwignerFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerFrame::to_string(self : SignaltransformwignerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_table_make(size : Int) -> SignaltransformwignerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerTable::len(self : SignaltransformwignerTable) -> Int { self.size }

pub fn SignaltransformwignerTable::get(self : SignaltransformwignerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerTable::set(self : SignaltransformwignerTable, i : Int, v : Double) -> SignaltransformwignerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerTable::sum(self : SignaltransformwignerTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerTable::mean(self : SignaltransformwignerTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerTable::scale(self : SignaltransformwignerTable, f : Double) -> SignaltransformwignerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerTable::add(self : SignaltransformwignerTable, other : SignaltransformwignerTable) -> SignaltransformwignerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerTable::copy(self : SignaltransformwignerTable) -> SignaltransformwignerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerTable::fill(self : SignaltransformwignerTable, v : Double) -> SignaltransformwignerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerTable::min(self : SignaltransformwignerTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerTable::max(self : SignaltransformwignerTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerTable::to_string(self : SignaltransformwignerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_graphn_make(size : Int) -> SignaltransformwignerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerGraphN::len(self : SignaltransformwignerGraphN) -> Int { self.size }

pub fn SignaltransformwignerGraphN::get(self : SignaltransformwignerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerGraphN::set(self : SignaltransformwignerGraphN, i : Int, v : Double) -> SignaltransformwignerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerGraphN::sum(self : SignaltransformwignerGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerGraphN::mean(self : SignaltransformwignerGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerGraphN::scale(self : SignaltransformwignerGraphN, f : Double) -> SignaltransformwignerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerGraphN::add(self : SignaltransformwignerGraphN, other : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerGraphN::copy(self : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerGraphN::fill(self : SignaltransformwignerGraphN, v : Double) -> SignaltransformwignerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerGraphN::min(self : SignaltransformwignerGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerGraphN::max(self : SignaltransformwignerGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerGraphN::to_string(self : SignaltransformwignerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_node_make(size : Int) -> SignaltransformwignerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerNode::len(self : SignaltransformwignerNode) -> Int { self.size }

pub fn SignaltransformwignerNode::get(self : SignaltransformwignerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerNode::set(self : SignaltransformwignerNode, i : Int, v : Double) -> SignaltransformwignerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerNode::sum(self : SignaltransformwignerNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerNode::mean(self : SignaltransformwignerNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerNode::scale(self : SignaltransformwignerNode, f : Double) -> SignaltransformwignerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerNode::add(self : SignaltransformwignerNode, other : SignaltransformwignerNode) -> SignaltransformwignerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerNode::copy(self : SignaltransformwignerNode) -> SignaltransformwignerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerNode::fill(self : SignaltransformwignerNode, v : Double) -> SignaltransformwignerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerNode::min(self : SignaltransformwignerNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerNode::max(self : SignaltransformwignerNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerNode::to_string(self : SignaltransformwignerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_edge_make(size : Int) -> SignaltransformwignerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerEdge::len(self : SignaltransformwignerEdge) -> Int { self.size }

pub fn SignaltransformwignerEdge::get(self : SignaltransformwignerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerEdge::set(self : SignaltransformwignerEdge, i : Int, v : Double) -> SignaltransformwignerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerEdge::sum(self : SignaltransformwignerEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerEdge::mean(self : SignaltransformwignerEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerEdge::scale(self : SignaltransformwignerEdge, f : Double) -> SignaltransformwignerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerEdge::add(self : SignaltransformwignerEdge, other : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerEdge::copy(self : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerEdge::fill(self : SignaltransformwignerEdge, v : Double) -> SignaltransformwignerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerEdge::min(self : SignaltransformwignerEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerEdge::max(self : SignaltransformwignerEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerEdge::to_string(self : SignaltransformwignerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_path_make(size : Int) -> SignaltransformwignerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerPath::len(self : SignaltransformwignerPath) -> Int { self.size }

pub fn SignaltransformwignerPath::get(self : SignaltransformwignerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerPath::set(self : SignaltransformwignerPath, i : Int, v : Double) -> SignaltransformwignerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerPath::sum(self : SignaltransformwignerPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerPath::mean(self : SignaltransformwignerPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerPath::scale(self : SignaltransformwignerPath, f : Double) -> SignaltransformwignerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerPath::add(self : SignaltransformwignerPath, other : SignaltransformwignerPath) -> SignaltransformwignerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerPath::copy(self : SignaltransformwignerPath) -> SignaltransformwignerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerPath::fill(self : SignaltransformwignerPath, v : Double) -> SignaltransformwignerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerPath::min(self : SignaltransformwignerPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerPath::max(self : SignaltransformwignerPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerPath::to_string(self : SignaltransformwignerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cluster_make(size : Int) -> SignaltransformwignerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerCluster::len(self : SignaltransformwignerCluster) -> Int { self.size }

pub fn SignaltransformwignerCluster::get(self : SignaltransformwignerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerCluster::set(self : SignaltransformwignerCluster, i : Int, v : Double) -> SignaltransformwignerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCluster::sum(self : SignaltransformwignerCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerCluster::mean(self : SignaltransformwignerCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerCluster::scale(self : SignaltransformwignerCluster, f : Double) -> SignaltransformwignerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCluster::add(self : SignaltransformwignerCluster, other : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerCluster::copy(self : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCluster::fill(self : SignaltransformwignerCluster, v : Double) -> SignaltransformwignerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCluster::min(self : SignaltransformwignerCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerCluster::max(self : SignaltransformwignerCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerCluster::to_string(self : SignaltransformwignerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_model_make(size : Int) -> SignaltransformwignerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerModel::len(self : SignaltransformwignerModel) -> Int { self.size }

pub fn SignaltransformwignerModel::get(self : SignaltransformwignerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerModel::set(self : SignaltransformwignerModel, i : Int, v : Double) -> SignaltransformwignerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerModel::sum(self : SignaltransformwignerModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerModel::mean(self : SignaltransformwignerModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerModel::scale(self : SignaltransformwignerModel, f : Double) -> SignaltransformwignerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerModel::add(self : SignaltransformwignerModel, other : SignaltransformwignerModel) -> SignaltransformwignerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerModel::copy(self : SignaltransformwignerModel) -> SignaltransformwignerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerModel::fill(self : SignaltransformwignerModel, v : Double) -> SignaltransformwignerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerModel::min(self : SignaltransformwignerModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerModel::max(self : SignaltransformwignerModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerModel::to_string(self : SignaltransformwignerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_layer_make(size : Int) -> SignaltransformwignerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerLayer::len(self : SignaltransformwignerLayer) -> Int { self.size }

pub fn SignaltransformwignerLayer::get(self : SignaltransformwignerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerLayer::set(self : SignaltransformwignerLayer, i : Int, v : Double) -> SignaltransformwignerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerLayer::sum(self : SignaltransformwignerLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerLayer::mean(self : SignaltransformwignerLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerLayer::scale(self : SignaltransformwignerLayer, f : Double) -> SignaltransformwignerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerLayer::add(self : SignaltransformwignerLayer, other : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerLayer::copy(self : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerLayer::fill(self : SignaltransformwignerLayer, v : Double) -> SignaltransformwignerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerLayer::min(self : SignaltransformwignerLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerLayer::max(self : SignaltransformwignerLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerLayer::to_string(self : SignaltransformwignerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_buffer_make(size : Int) -> SignaltransformwignerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerBuffer::len(self : SignaltransformwignerBuffer) -> Int { self.size }

pub fn SignaltransformwignerBuffer::get(self : SignaltransformwignerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerBuffer::set(self : SignaltransformwignerBuffer, i : Int, v : Double) -> SignaltransformwignerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerBuffer::sum(self : SignaltransformwignerBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerBuffer::mean(self : SignaltransformwignerBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerBuffer::scale(self : SignaltransformwignerBuffer, f : Double) -> SignaltransformwignerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerBuffer::add(self : SignaltransformwignerBuffer, other : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerBuffer::copy(self : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerBuffer::fill(self : SignaltransformwignerBuffer, v : Double) -> SignaltransformwignerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerBuffer::min(self : SignaltransformwignerBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerBuffer::max(self : SignaltransformwignerBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerBuffer::to_string(self : SignaltransformwignerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cursor_make(size : Int) -> SignaltransformwignerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerCursor::len(self : SignaltransformwignerCursor) -> Int { self.size }

pub fn SignaltransformwignerCursor::get(self : SignaltransformwignerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerCursor::set(self : SignaltransformwignerCursor, i : Int, v : Double) -> SignaltransformwignerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCursor::sum(self : SignaltransformwignerCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerCursor::mean(self : SignaltransformwignerCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerCursor::scale(self : SignaltransformwignerCursor, f : Double) -> SignaltransformwignerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCursor::add(self : SignaltransformwignerCursor, other : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerCursor::copy(self : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCursor::fill(self : SignaltransformwignerCursor, v : Double) -> SignaltransformwignerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerCursor::min(self : SignaltransformwignerCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerCursor::max(self : SignaltransformwignerCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerCursor::to_string(self : SignaltransformwignerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_view_make(size : Int) -> SignaltransformwignerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerView::len(self : SignaltransformwignerView) -> Int { self.size }

pub fn SignaltransformwignerView::get(self : SignaltransformwignerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerView::set(self : SignaltransformwignerView, i : Int, v : Double) -> SignaltransformwignerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerView::sum(self : SignaltransformwignerView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerView::mean(self : SignaltransformwignerView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerView::scale(self : SignaltransformwignerView, f : Double) -> SignaltransformwignerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerView::add(self : SignaltransformwignerView, other : SignaltransformwignerView) -> SignaltransformwignerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerView::copy(self : SignaltransformwignerView) -> SignaltransformwignerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerView::fill(self : SignaltransformwignerView, v : Double) -> SignaltransformwignerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerView::min(self : SignaltransformwignerView) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerView::max(self : SignaltransformwignerView) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerView::to_string(self : SignaltransformwignerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_range_make(size : Int) -> SignaltransformwignerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerRange::len(self : SignaltransformwignerRange) -> Int { self.size }

pub fn SignaltransformwignerRange::get(self : SignaltransformwignerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerRange::set(self : SignaltransformwignerRange, i : Int, v : Double) -> SignaltransformwignerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerRange::sum(self : SignaltransformwignerRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerRange::mean(self : SignaltransformwignerRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerRange::scale(self : SignaltransformwignerRange, f : Double) -> SignaltransformwignerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerRange::add(self : SignaltransformwignerRange, other : SignaltransformwignerRange) -> SignaltransformwignerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerRange::copy(self : SignaltransformwignerRange) -> SignaltransformwignerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerRange::fill(self : SignaltransformwignerRange, v : Double) -> SignaltransformwignerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerRange::min(self : SignaltransformwignerRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerRange::max(self : SignaltransformwignerRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerRange::to_string(self : SignaltransformwignerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_slice_make(size : Int) -> SignaltransformwignerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformwignerSlice::len(self : SignaltransformwignerSlice) -> Int { self.size }

pub fn SignaltransformwignerSlice::get(self : SignaltransformwignerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformwignerSlice::set(self : SignaltransformwignerSlice, i : Int, v : Double) -> SignaltransformwignerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerSlice::sum(self : SignaltransformwignerSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformwignerSlice::mean(self : SignaltransformwignerSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformwignerSlice::scale(self : SignaltransformwignerSlice, f : Double) -> SignaltransformwignerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerSlice::add(self : SignaltransformwignerSlice, other : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformwignerSlice::copy(self : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerSlice::fill(self : SignaltransformwignerSlice, v : Double) -> SignaltransformwignerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformwignerSlice::min(self : SignaltransformwignerSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformwignerSlice::max(self : SignaltransformwignerSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformwignerSlice::to_string(self : SignaltransformwignerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

