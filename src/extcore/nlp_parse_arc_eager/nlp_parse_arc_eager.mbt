///===
/// extcore/nlp_parse_arc_eager

pub(all) struct NlpparsearceagerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_arc_eager_make_point(x : Double, y : Double) -> NlpparsearceagerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_arc_eager_make_point3(x : Double, y : Double, z : Double) -> NlpparsearceagerPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsearceagerPoint::x(self : NlpparsearceagerPoint) -> Double { self.x }

pub fn NlpparsearceagerPoint::y(self : NlpparsearceagerPoint) -> Double { self.y }

pub fn NlpparsearceagerPoint::z(self : NlpparsearceagerPoint) -> Double { self.z }

pub fn NlpparsearceagerPoint::label(self : NlpparsearceagerPoint) -> Int { self.label }

pub fn NlpparsearceagerPoint::dist(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsearceagerPoint::add(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsearceagerPoint::sub(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsearceagerPoint::scale(self : NlpparsearceagerPoint, s : Double) -> NlpparsearceagerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsearceagerPoint::dot(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsearceagerPoint::cross(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsearceagerPoint::norm(self : NlpparsearceagerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsearceagerPoint::normalize(self : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsearceagerPoint::negate(self : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsearceagerPoint::mid(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsearceagerPoint::lerp(self : NlpparsearceagerPoint, other : NlpparsearceagerPoint, t : Double) -> NlpparsearceagerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsearceagerPoint::to_string(self : NlpparsearceagerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsearceagerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_arc_eager_make_series(vals : Array[Double], name : String) -> NlpparsearceagerSeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsearceagerSeries::len(self : NlpparsearceagerSeries) -> Int { self.vals.length() }

pub fn NlpparsearceagerSeries::sum(self : NlpparsearceagerSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsearceagerSeries::mean(self : NlpparsearceagerSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsearceagerSeries::min(self : NlpparsearceagerSeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsearceagerSeries::max(self : NlpparsearceagerSeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsearceagerSeries::range(self : NlpparsearceagerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsearceagerSeries::variance(self : NlpparsearceagerSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsearceagerSeries::std(self : NlpparsearceagerSeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsearceagerSeries::median(self : NlpparsearceagerSeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsearceagerSeries::scale(self : NlpparsearceagerSeries, f : Double) -> NlpparsearceagerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsearceagerSeries::add(self : NlpparsearceagerSeries, other : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsearceagerSeries::sub(self : NlpparsearceagerSeries, other : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsearceagerSeries::normalize(self : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsearceagerSeries::cumsum(self : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsearceagerSeries::to_string(self : NlpparsearceagerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsearceagerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_arc_eager_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsearceagerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_arc_eager_matrix_identity(n : Int) -> NlpparsearceagerMatrix {
  let m = nlp_parse_arc_eager_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsearceagerMatrix::get(self : NlpparsearceagerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsearceagerMatrix::transpose(self : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  let result = nlp_parse_arc_eager_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsearceagerMatrix::add(self : NlpparsearceagerMatrix, other : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_arc_eager_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsearceagerMatrix::scale(self : NlpparsearceagerMatrix, s : Double) -> NlpparsearceagerMatrix {
  let result = nlp_parse_arc_eager_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsearceagerMatrix::multiply(self : NlpparsearceagerMatrix, other : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  if self.cols != other.rows { return nlp_parse_arc_eager_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_arc_eager_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparsearceagerMatrix::trace(self : NlpparsearceagerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsearceagerMatrix::det(self : NlpparsearceagerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsearceagerMatrix::norm(self : NlpparsearceagerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsearceagerMatrix::to_string(self : NlpparsearceagerMatrix) -> String {
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

pub(all) struct NlpparsearceagerVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_arc_eager_make_vector(comps : Array[Double]) -> NlpparsearceagerVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_arc_eager_vector_zero(dim : Int) -> NlpparsearceagerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsearceagerVector::add(self : NlpparsearceagerVector, other : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsearceagerVector::sub(self : NlpparsearceagerVector, other : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsearceagerVector::scale(self : NlpparsearceagerVector, s : Double) -> NlpparsearceagerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsearceagerVector::dot(self : NlpparsearceagerVector, other : NlpparsearceagerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsearceagerVector::norm(self : NlpparsearceagerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsearceagerVector::normalize(self : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsearceagerVector::dist(self : NlpparsearceagerVector, other : NlpparsearceagerVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsearceagerVector::to_string(self : NlpparsearceagerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_arc_eager_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_arc_eager_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_arc_eager_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_arc_eager_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_arc_eager_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_arc_eager_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_arc_eager_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_arc_eager_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_arc_eager_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_arc_eager_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_arc_eager_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_arc_eager_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_arc_eager_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_arc_eager_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_arc_eager_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_arc_eager_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_arc_eager_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_arc_eager_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_arc_eager_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_arc_eager_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_arc_eager_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_arc_eager_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_arc_eager_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_arc_eager_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_arc_eager_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_arc_eager_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_arc_eager_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_arc_eager_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_arc_eager_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsearceagerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_frame_make(size : Int) -> NlpparsearceagerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerFrame::len(self : NlpparsearceagerFrame) -> Int { self.size }

pub fn NlpparsearceagerFrame::get(self : NlpparsearceagerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerFrame::set(self : NlpparsearceagerFrame, i : Int, v : Double) -> NlpparsearceagerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerFrame::sum(self : NlpparsearceagerFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerFrame::mean(self : NlpparsearceagerFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerFrame::scale(self : NlpparsearceagerFrame, f : Double) -> NlpparsearceagerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerFrame::add(self : NlpparsearceagerFrame, other : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerFrame::copy(self : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerFrame::fill(self : NlpparsearceagerFrame, v : Double) -> NlpparsearceagerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerFrame::min(self : NlpparsearceagerFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerFrame::max(self : NlpparsearceagerFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerFrame::to_string(self : NlpparsearceagerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_table_make(size : Int) -> NlpparsearceagerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerTable::len(self : NlpparsearceagerTable) -> Int { self.size }

pub fn NlpparsearceagerTable::get(self : NlpparsearceagerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerTable::set(self : NlpparsearceagerTable, i : Int, v : Double) -> NlpparsearceagerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerTable::sum(self : NlpparsearceagerTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerTable::mean(self : NlpparsearceagerTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerTable::scale(self : NlpparsearceagerTable, f : Double) -> NlpparsearceagerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerTable::add(self : NlpparsearceagerTable, other : NlpparsearceagerTable) -> NlpparsearceagerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerTable::copy(self : NlpparsearceagerTable) -> NlpparsearceagerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerTable::fill(self : NlpparsearceagerTable, v : Double) -> NlpparsearceagerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerTable::min(self : NlpparsearceagerTable) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerTable::max(self : NlpparsearceagerTable) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerTable::to_string(self : NlpparsearceagerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_graphn_make(size : Int) -> NlpparsearceagerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerGraphN::len(self : NlpparsearceagerGraphN) -> Int { self.size }

pub fn NlpparsearceagerGraphN::get(self : NlpparsearceagerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerGraphN::set(self : NlpparsearceagerGraphN, i : Int, v : Double) -> NlpparsearceagerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerGraphN::sum(self : NlpparsearceagerGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerGraphN::mean(self : NlpparsearceagerGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerGraphN::scale(self : NlpparsearceagerGraphN, f : Double) -> NlpparsearceagerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerGraphN::add(self : NlpparsearceagerGraphN, other : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerGraphN::copy(self : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerGraphN::fill(self : NlpparsearceagerGraphN, v : Double) -> NlpparsearceagerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerGraphN::min(self : NlpparsearceagerGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerGraphN::max(self : NlpparsearceagerGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerGraphN::to_string(self : NlpparsearceagerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_node_make(size : Int) -> NlpparsearceagerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerNode::len(self : NlpparsearceagerNode) -> Int { self.size }

pub fn NlpparsearceagerNode::get(self : NlpparsearceagerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerNode::set(self : NlpparsearceagerNode, i : Int, v : Double) -> NlpparsearceagerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerNode::sum(self : NlpparsearceagerNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerNode::mean(self : NlpparsearceagerNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerNode::scale(self : NlpparsearceagerNode, f : Double) -> NlpparsearceagerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerNode::add(self : NlpparsearceagerNode, other : NlpparsearceagerNode) -> NlpparsearceagerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerNode::copy(self : NlpparsearceagerNode) -> NlpparsearceagerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerNode::fill(self : NlpparsearceagerNode, v : Double) -> NlpparsearceagerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerNode::min(self : NlpparsearceagerNode) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerNode::max(self : NlpparsearceagerNode) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerNode::to_string(self : NlpparsearceagerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_edge_make(size : Int) -> NlpparsearceagerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerEdge::len(self : NlpparsearceagerEdge) -> Int { self.size }

pub fn NlpparsearceagerEdge::get(self : NlpparsearceagerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerEdge::set(self : NlpparsearceagerEdge, i : Int, v : Double) -> NlpparsearceagerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerEdge::sum(self : NlpparsearceagerEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerEdge::mean(self : NlpparsearceagerEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerEdge::scale(self : NlpparsearceagerEdge, f : Double) -> NlpparsearceagerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerEdge::add(self : NlpparsearceagerEdge, other : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerEdge::copy(self : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerEdge::fill(self : NlpparsearceagerEdge, v : Double) -> NlpparsearceagerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerEdge::min(self : NlpparsearceagerEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerEdge::max(self : NlpparsearceagerEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerEdge::to_string(self : NlpparsearceagerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_path_make(size : Int) -> NlpparsearceagerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerPath::len(self : NlpparsearceagerPath) -> Int { self.size }

pub fn NlpparsearceagerPath::get(self : NlpparsearceagerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerPath::set(self : NlpparsearceagerPath, i : Int, v : Double) -> NlpparsearceagerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerPath::sum(self : NlpparsearceagerPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerPath::mean(self : NlpparsearceagerPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerPath::scale(self : NlpparsearceagerPath, f : Double) -> NlpparsearceagerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerPath::add(self : NlpparsearceagerPath, other : NlpparsearceagerPath) -> NlpparsearceagerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerPath::copy(self : NlpparsearceagerPath) -> NlpparsearceagerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerPath::fill(self : NlpparsearceagerPath, v : Double) -> NlpparsearceagerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerPath::min(self : NlpparsearceagerPath) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerPath::max(self : NlpparsearceagerPath) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerPath::to_string(self : NlpparsearceagerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cluster_make(size : Int) -> NlpparsearceagerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerCluster::len(self : NlpparsearceagerCluster) -> Int { self.size }

pub fn NlpparsearceagerCluster::get(self : NlpparsearceagerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerCluster::set(self : NlpparsearceagerCluster, i : Int, v : Double) -> NlpparsearceagerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCluster::sum(self : NlpparsearceagerCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerCluster::mean(self : NlpparsearceagerCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerCluster::scale(self : NlpparsearceagerCluster, f : Double) -> NlpparsearceagerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCluster::add(self : NlpparsearceagerCluster, other : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerCluster::copy(self : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCluster::fill(self : NlpparsearceagerCluster, v : Double) -> NlpparsearceagerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCluster::min(self : NlpparsearceagerCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerCluster::max(self : NlpparsearceagerCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerCluster::to_string(self : NlpparsearceagerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_model_make(size : Int) -> NlpparsearceagerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerModel::len(self : NlpparsearceagerModel) -> Int { self.size }

pub fn NlpparsearceagerModel::get(self : NlpparsearceagerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerModel::set(self : NlpparsearceagerModel, i : Int, v : Double) -> NlpparsearceagerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerModel::sum(self : NlpparsearceagerModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerModel::mean(self : NlpparsearceagerModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerModel::scale(self : NlpparsearceagerModel, f : Double) -> NlpparsearceagerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerModel::add(self : NlpparsearceagerModel, other : NlpparsearceagerModel) -> NlpparsearceagerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerModel::copy(self : NlpparsearceagerModel) -> NlpparsearceagerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerModel::fill(self : NlpparsearceagerModel, v : Double) -> NlpparsearceagerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerModel::min(self : NlpparsearceagerModel) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerModel::max(self : NlpparsearceagerModel) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerModel::to_string(self : NlpparsearceagerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_layer_make(size : Int) -> NlpparsearceagerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerLayer::len(self : NlpparsearceagerLayer) -> Int { self.size }

pub fn NlpparsearceagerLayer::get(self : NlpparsearceagerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerLayer::set(self : NlpparsearceagerLayer, i : Int, v : Double) -> NlpparsearceagerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerLayer::sum(self : NlpparsearceagerLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerLayer::mean(self : NlpparsearceagerLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerLayer::scale(self : NlpparsearceagerLayer, f : Double) -> NlpparsearceagerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerLayer::add(self : NlpparsearceagerLayer, other : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerLayer::copy(self : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerLayer::fill(self : NlpparsearceagerLayer, v : Double) -> NlpparsearceagerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerLayer::min(self : NlpparsearceagerLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerLayer::max(self : NlpparsearceagerLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerLayer::to_string(self : NlpparsearceagerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_buffer_make(size : Int) -> NlpparsearceagerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerBuffer::len(self : NlpparsearceagerBuffer) -> Int { self.size }

pub fn NlpparsearceagerBuffer::get(self : NlpparsearceagerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerBuffer::set(self : NlpparsearceagerBuffer, i : Int, v : Double) -> NlpparsearceagerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerBuffer::sum(self : NlpparsearceagerBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerBuffer::mean(self : NlpparsearceagerBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerBuffer::scale(self : NlpparsearceagerBuffer, f : Double) -> NlpparsearceagerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerBuffer::add(self : NlpparsearceagerBuffer, other : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerBuffer::copy(self : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerBuffer::fill(self : NlpparsearceagerBuffer, v : Double) -> NlpparsearceagerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerBuffer::min(self : NlpparsearceagerBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerBuffer::max(self : NlpparsearceagerBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerBuffer::to_string(self : NlpparsearceagerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cursor_make(size : Int) -> NlpparsearceagerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerCursor::len(self : NlpparsearceagerCursor) -> Int { self.size }

pub fn NlpparsearceagerCursor::get(self : NlpparsearceagerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerCursor::set(self : NlpparsearceagerCursor, i : Int, v : Double) -> NlpparsearceagerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCursor::sum(self : NlpparsearceagerCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerCursor::mean(self : NlpparsearceagerCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerCursor::scale(self : NlpparsearceagerCursor, f : Double) -> NlpparsearceagerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCursor::add(self : NlpparsearceagerCursor, other : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerCursor::copy(self : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCursor::fill(self : NlpparsearceagerCursor, v : Double) -> NlpparsearceagerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerCursor::min(self : NlpparsearceagerCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerCursor::max(self : NlpparsearceagerCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerCursor::to_string(self : NlpparsearceagerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_view_make(size : Int) -> NlpparsearceagerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerView::len(self : NlpparsearceagerView) -> Int { self.size }

pub fn NlpparsearceagerView::get(self : NlpparsearceagerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerView::set(self : NlpparsearceagerView, i : Int, v : Double) -> NlpparsearceagerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerView::sum(self : NlpparsearceagerView) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerView::mean(self : NlpparsearceagerView) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerView::scale(self : NlpparsearceagerView, f : Double) -> NlpparsearceagerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerView::add(self : NlpparsearceagerView, other : NlpparsearceagerView) -> NlpparsearceagerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerView::copy(self : NlpparsearceagerView) -> NlpparsearceagerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerView::fill(self : NlpparsearceagerView, v : Double) -> NlpparsearceagerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerView::min(self : NlpparsearceagerView) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerView::max(self : NlpparsearceagerView) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerView::to_string(self : NlpparsearceagerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_range_make(size : Int) -> NlpparsearceagerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerRange::len(self : NlpparsearceagerRange) -> Int { self.size }

pub fn NlpparsearceagerRange::get(self : NlpparsearceagerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerRange::set(self : NlpparsearceagerRange, i : Int, v : Double) -> NlpparsearceagerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerRange::sum(self : NlpparsearceagerRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerRange::mean(self : NlpparsearceagerRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerRange::scale(self : NlpparsearceagerRange, f : Double) -> NlpparsearceagerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerRange::add(self : NlpparsearceagerRange, other : NlpparsearceagerRange) -> NlpparsearceagerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerRange::copy(self : NlpparsearceagerRange) -> NlpparsearceagerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerRange::fill(self : NlpparsearceagerRange, v : Double) -> NlpparsearceagerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerRange::min(self : NlpparsearceagerRange) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerRange::max(self : NlpparsearceagerRange) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerRange::to_string(self : NlpparsearceagerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_slice_make(size : Int) -> NlpparsearceagerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearceagerSlice::len(self : NlpparsearceagerSlice) -> Int { self.size }

pub fn NlpparsearceagerSlice::get(self : NlpparsearceagerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearceagerSlice::set(self : NlpparsearceagerSlice, i : Int, v : Double) -> NlpparsearceagerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerSlice::sum(self : NlpparsearceagerSlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsearceagerSlice::mean(self : NlpparsearceagerSlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsearceagerSlice::scale(self : NlpparsearceagerSlice, f : Double) -> NlpparsearceagerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerSlice::add(self : NlpparsearceagerSlice, other : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearceagerSlice::copy(self : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerSlice::fill(self : NlpparsearceagerSlice, v : Double) -> NlpparsearceagerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearceagerSlice::min(self : NlpparsearceagerSlice) -> Double { @_common.min(self.data) }

pub fn NlpparsearceagerSlice::max(self : NlpparsearceagerSlice) -> Double { @_common.max(self.data) }

pub fn NlpparsearceagerSlice::to_string(self : NlpparsearceagerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

