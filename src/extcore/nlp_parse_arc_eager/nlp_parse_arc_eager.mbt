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

pub fn nlp_parse_arc_eager_frame_len(s : NlpparsearceagerFrame) -> Int { s.size }

pub fn nlp_parse_arc_eager_frame_get(s : NlpparsearceagerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_frame_set(s : NlpparsearceagerFrame, i : Int, v : Double) -> NlpparsearceagerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_frame_sum(s : NlpparsearceagerFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_frame_mean(s : NlpparsearceagerFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_frame_scale(s : NlpparsearceagerFrame, f : Double) -> NlpparsearceagerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_frame_add(a : NlpparsearceagerFrame, b : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_frame_copy(s : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_frame_fill(s : NlpparsearceagerFrame, v : Double) -> NlpparsearceagerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_frame_min(s : NlpparsearceagerFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_frame_max(s : NlpparsearceagerFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_frame_to_string(s : NlpparsearceagerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_table_make(size : Int) -> NlpparsearceagerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_table_len(s : NlpparsearceagerTable) -> Int { s.size }

pub fn nlp_parse_arc_eager_table_get(s : NlpparsearceagerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_table_set(s : NlpparsearceagerTable, i : Int, v : Double) -> NlpparsearceagerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_table_sum(s : NlpparsearceagerTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_table_mean(s : NlpparsearceagerTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_table_scale(s : NlpparsearceagerTable, f : Double) -> NlpparsearceagerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_table_add(a : NlpparsearceagerTable, b : NlpparsearceagerTable) -> NlpparsearceagerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_table_copy(s : NlpparsearceagerTable) -> NlpparsearceagerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_table_fill(s : NlpparsearceagerTable, v : Double) -> NlpparsearceagerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_table_min(s : NlpparsearceagerTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_table_max(s : NlpparsearceagerTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_table_to_string(s : NlpparsearceagerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_graphn_make(size : Int) -> NlpparsearceagerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_graphn_len(s : NlpparsearceagerGraphN) -> Int { s.size }

pub fn nlp_parse_arc_eager_graphn_get(s : NlpparsearceagerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_graphn_set(s : NlpparsearceagerGraphN, i : Int, v : Double) -> NlpparsearceagerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_graphn_sum(s : NlpparsearceagerGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_graphn_mean(s : NlpparsearceagerGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_graphn_scale(s : NlpparsearceagerGraphN, f : Double) -> NlpparsearceagerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_graphn_add(a : NlpparsearceagerGraphN, b : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_graphn_copy(s : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_graphn_fill(s : NlpparsearceagerGraphN, v : Double) -> NlpparsearceagerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_graphn_min(s : NlpparsearceagerGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_graphn_max(s : NlpparsearceagerGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_graphn_to_string(s : NlpparsearceagerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_node_make(size : Int) -> NlpparsearceagerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_node_len(s : NlpparsearceagerNode) -> Int { s.size }

pub fn nlp_parse_arc_eager_node_get(s : NlpparsearceagerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_node_set(s : NlpparsearceagerNode, i : Int, v : Double) -> NlpparsearceagerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_node_sum(s : NlpparsearceagerNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_node_mean(s : NlpparsearceagerNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_node_scale(s : NlpparsearceagerNode, f : Double) -> NlpparsearceagerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_node_add(a : NlpparsearceagerNode, b : NlpparsearceagerNode) -> NlpparsearceagerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_node_copy(s : NlpparsearceagerNode) -> NlpparsearceagerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_node_fill(s : NlpparsearceagerNode, v : Double) -> NlpparsearceagerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_node_min(s : NlpparsearceagerNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_node_max(s : NlpparsearceagerNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_node_to_string(s : NlpparsearceagerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_edge_make(size : Int) -> NlpparsearceagerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_edge_len(s : NlpparsearceagerEdge) -> Int { s.size }

pub fn nlp_parse_arc_eager_edge_get(s : NlpparsearceagerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_edge_set(s : NlpparsearceagerEdge, i : Int, v : Double) -> NlpparsearceagerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_edge_sum(s : NlpparsearceagerEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_edge_mean(s : NlpparsearceagerEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_edge_scale(s : NlpparsearceagerEdge, f : Double) -> NlpparsearceagerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_edge_add(a : NlpparsearceagerEdge, b : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_edge_copy(s : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_edge_fill(s : NlpparsearceagerEdge, v : Double) -> NlpparsearceagerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_edge_min(s : NlpparsearceagerEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_edge_max(s : NlpparsearceagerEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_edge_to_string(s : NlpparsearceagerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_path_make(size : Int) -> NlpparsearceagerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_path_len(s : NlpparsearceagerPath) -> Int { s.size }

pub fn nlp_parse_arc_eager_path_get(s : NlpparsearceagerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_path_set(s : NlpparsearceagerPath, i : Int, v : Double) -> NlpparsearceagerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_path_sum(s : NlpparsearceagerPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_path_mean(s : NlpparsearceagerPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_path_scale(s : NlpparsearceagerPath, f : Double) -> NlpparsearceagerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_path_add(a : NlpparsearceagerPath, b : NlpparsearceagerPath) -> NlpparsearceagerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_path_copy(s : NlpparsearceagerPath) -> NlpparsearceagerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_path_fill(s : NlpparsearceagerPath, v : Double) -> NlpparsearceagerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_path_min(s : NlpparsearceagerPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_path_max(s : NlpparsearceagerPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_path_to_string(s : NlpparsearceagerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cluster_make(size : Int) -> NlpparsearceagerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_cluster_len(s : NlpparsearceagerCluster) -> Int { s.size }

pub fn nlp_parse_arc_eager_cluster_get(s : NlpparsearceagerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_cluster_set(s : NlpparsearceagerCluster, i : Int, v : Double) -> NlpparsearceagerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cluster_sum(s : NlpparsearceagerCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_cluster_mean(s : NlpparsearceagerCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_cluster_scale(s : NlpparsearceagerCluster, f : Double) -> NlpparsearceagerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cluster_add(a : NlpparsearceagerCluster, b : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_cluster_copy(s : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cluster_fill(s : NlpparsearceagerCluster, v : Double) -> NlpparsearceagerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cluster_min(s : NlpparsearceagerCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_cluster_max(s : NlpparsearceagerCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_cluster_to_string(s : NlpparsearceagerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_model_make(size : Int) -> NlpparsearceagerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_model_len(s : NlpparsearceagerModel) -> Int { s.size }

pub fn nlp_parse_arc_eager_model_get(s : NlpparsearceagerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_model_set(s : NlpparsearceagerModel, i : Int, v : Double) -> NlpparsearceagerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_model_sum(s : NlpparsearceagerModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_model_mean(s : NlpparsearceagerModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_model_scale(s : NlpparsearceagerModel, f : Double) -> NlpparsearceagerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_model_add(a : NlpparsearceagerModel, b : NlpparsearceagerModel) -> NlpparsearceagerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_model_copy(s : NlpparsearceagerModel) -> NlpparsearceagerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_model_fill(s : NlpparsearceagerModel, v : Double) -> NlpparsearceagerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_model_min(s : NlpparsearceagerModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_model_max(s : NlpparsearceagerModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_model_to_string(s : NlpparsearceagerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_layer_make(size : Int) -> NlpparsearceagerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_layer_len(s : NlpparsearceagerLayer) -> Int { s.size }

pub fn nlp_parse_arc_eager_layer_get(s : NlpparsearceagerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_layer_set(s : NlpparsearceagerLayer, i : Int, v : Double) -> NlpparsearceagerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_layer_sum(s : NlpparsearceagerLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_layer_mean(s : NlpparsearceagerLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_layer_scale(s : NlpparsearceagerLayer, f : Double) -> NlpparsearceagerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_layer_add(a : NlpparsearceagerLayer, b : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_layer_copy(s : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_layer_fill(s : NlpparsearceagerLayer, v : Double) -> NlpparsearceagerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_layer_min(s : NlpparsearceagerLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_layer_max(s : NlpparsearceagerLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_layer_to_string(s : NlpparsearceagerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_buffer_make(size : Int) -> NlpparsearceagerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_buffer_len(s : NlpparsearceagerBuffer) -> Int { s.size }

pub fn nlp_parse_arc_eager_buffer_get(s : NlpparsearceagerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_buffer_set(s : NlpparsearceagerBuffer, i : Int, v : Double) -> NlpparsearceagerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_buffer_sum(s : NlpparsearceagerBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_buffer_mean(s : NlpparsearceagerBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_buffer_scale(s : NlpparsearceagerBuffer, f : Double) -> NlpparsearceagerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_buffer_add(a : NlpparsearceagerBuffer, b : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_buffer_copy(s : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_buffer_fill(s : NlpparsearceagerBuffer, v : Double) -> NlpparsearceagerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_buffer_min(s : NlpparsearceagerBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_buffer_max(s : NlpparsearceagerBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_buffer_to_string(s : NlpparsearceagerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cursor_make(size : Int) -> NlpparsearceagerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_cursor_len(s : NlpparsearceagerCursor) -> Int { s.size }

pub fn nlp_parse_arc_eager_cursor_get(s : NlpparsearceagerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_cursor_set(s : NlpparsearceagerCursor, i : Int, v : Double) -> NlpparsearceagerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cursor_sum(s : NlpparsearceagerCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_cursor_mean(s : NlpparsearceagerCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_cursor_scale(s : NlpparsearceagerCursor, f : Double) -> NlpparsearceagerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cursor_add(a : NlpparsearceagerCursor, b : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_cursor_copy(s : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cursor_fill(s : NlpparsearceagerCursor, v : Double) -> NlpparsearceagerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_cursor_min(s : NlpparsearceagerCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_cursor_max(s : NlpparsearceagerCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_cursor_to_string(s : NlpparsearceagerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_view_make(size : Int) -> NlpparsearceagerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_view_len(s : NlpparsearceagerView) -> Int { s.size }

pub fn nlp_parse_arc_eager_view_get(s : NlpparsearceagerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_view_set(s : NlpparsearceagerView, i : Int, v : Double) -> NlpparsearceagerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_view_sum(s : NlpparsearceagerView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_view_mean(s : NlpparsearceagerView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_view_scale(s : NlpparsearceagerView, f : Double) -> NlpparsearceagerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_view_add(a : NlpparsearceagerView, b : NlpparsearceagerView) -> NlpparsearceagerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_view_copy(s : NlpparsearceagerView) -> NlpparsearceagerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_view_fill(s : NlpparsearceagerView, v : Double) -> NlpparsearceagerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_view_min(s : NlpparsearceagerView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_view_max(s : NlpparsearceagerView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_view_to_string(s : NlpparsearceagerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_range_make(size : Int) -> NlpparsearceagerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_range_len(s : NlpparsearceagerRange) -> Int { s.size }

pub fn nlp_parse_arc_eager_range_get(s : NlpparsearceagerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_range_set(s : NlpparsearceagerRange, i : Int, v : Double) -> NlpparsearceagerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_range_sum(s : NlpparsearceagerRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_range_mean(s : NlpparsearceagerRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_range_scale(s : NlpparsearceagerRange, f : Double) -> NlpparsearceagerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_range_add(a : NlpparsearceagerRange, b : NlpparsearceagerRange) -> NlpparsearceagerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_range_copy(s : NlpparsearceagerRange) -> NlpparsearceagerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_range_fill(s : NlpparsearceagerRange, v : Double) -> NlpparsearceagerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_range_min(s : NlpparsearceagerRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_range_max(s : NlpparsearceagerRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_range_to_string(s : NlpparsearceagerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_slice_make(size : Int) -> NlpparsearceagerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_slice_len(s : NlpparsearceagerSlice) -> Int { s.size }

pub fn nlp_parse_arc_eager_slice_get(s : NlpparsearceagerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_slice_set(s : NlpparsearceagerSlice, i : Int, v : Double) -> NlpparsearceagerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_slice_sum(s : NlpparsearceagerSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_eager_slice_mean(s : NlpparsearceagerSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_eager_slice_scale(s : NlpparsearceagerSlice, f : Double) -> NlpparsearceagerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_slice_add(a : NlpparsearceagerSlice, b : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_eager_slice_copy(s : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_slice_fill(s : NlpparsearceagerSlice, v : Double) -> NlpparsearceagerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_eager_slice_min(s : NlpparsearceagerSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_eager_slice_max(s : NlpparsearceagerSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_eager_slice_to_string(s : NlpparsearceagerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

