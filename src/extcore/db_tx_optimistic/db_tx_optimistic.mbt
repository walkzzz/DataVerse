///===
/// extcore/db_tx_optimistic

pub(all) struct DbtxoptimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_optimistic_make_point(x : Double, y : Double) -> DbtxoptimisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_optimistic_make_point3(x : Double, y : Double, z : Double) -> DbtxoptimisticPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxoptimisticPoint::x(self : DbtxoptimisticPoint) -> Double { self.x }

pub fn DbtxoptimisticPoint::y(self : DbtxoptimisticPoint) -> Double { self.y }

pub fn DbtxoptimisticPoint::z(self : DbtxoptimisticPoint) -> Double { self.z }

pub fn DbtxoptimisticPoint::label(self : DbtxoptimisticPoint) -> Int { self.label }

pub fn DbtxoptimisticPoint::dist(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxoptimisticPoint::add(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxoptimisticPoint::sub(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxoptimisticPoint::scale(self : DbtxoptimisticPoint, s : Double) -> DbtxoptimisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxoptimisticPoint::dot(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxoptimisticPoint::cross(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxoptimisticPoint::norm(self : DbtxoptimisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxoptimisticPoint::normalize(self : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxoptimisticPoint::negate(self : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxoptimisticPoint::mid(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxoptimisticPoint::lerp(self : DbtxoptimisticPoint, other : DbtxoptimisticPoint, t : Double) -> DbtxoptimisticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxoptimisticPoint::to_string(self : DbtxoptimisticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxoptimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_optimistic_make_series(vals : Array[Double], name : String) -> DbtxoptimisticSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxoptimisticSeries::len(self : DbtxoptimisticSeries) -> Int { self.vals.length() }

pub fn DbtxoptimisticSeries::sum(self : DbtxoptimisticSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxoptimisticSeries::mean(self : DbtxoptimisticSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxoptimisticSeries::min(self : DbtxoptimisticSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxoptimisticSeries::max(self : DbtxoptimisticSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxoptimisticSeries::range(self : DbtxoptimisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxoptimisticSeries::variance(self : DbtxoptimisticSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxoptimisticSeries::std(self : DbtxoptimisticSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxoptimisticSeries::median(self : DbtxoptimisticSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxoptimisticSeries::scale(self : DbtxoptimisticSeries, f : Double) -> DbtxoptimisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxoptimisticSeries::add(self : DbtxoptimisticSeries, other : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxoptimisticSeries::sub(self : DbtxoptimisticSeries, other : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxoptimisticSeries::normalize(self : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxoptimisticSeries::cumsum(self : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxoptimisticSeries::to_string(self : DbtxoptimisticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxoptimisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_optimistic_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxoptimisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_optimistic_matrix_identity(n : Int) -> DbtxoptimisticMatrix {
  let m = db_tx_optimistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxoptimisticMatrix::get(self : DbtxoptimisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxoptimisticMatrix::transpose(self : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxoptimisticMatrix::add(self : DbtxoptimisticMatrix, other : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_optimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxoptimisticMatrix::scale(self : DbtxoptimisticMatrix, s : Double) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxoptimisticMatrix::multiply(self : DbtxoptimisticMatrix, other : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  if self.cols != other.rows { return db_tx_optimistic_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_optimistic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxoptimisticMatrix::trace(self : DbtxoptimisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxoptimisticMatrix::det(self : DbtxoptimisticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxoptimisticMatrix::norm(self : DbtxoptimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxoptimisticMatrix::to_string(self : DbtxoptimisticMatrix) -> String {
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

pub(all) struct DbtxoptimisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_optimistic_make_vector(comps : Array[Double]) -> DbtxoptimisticVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_optimistic_vector_zero(dim : Int) -> DbtxoptimisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxoptimisticVector::add(self : DbtxoptimisticVector, other : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxoptimisticVector::sub(self : DbtxoptimisticVector, other : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxoptimisticVector::scale(self : DbtxoptimisticVector, s : Double) -> DbtxoptimisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxoptimisticVector::dot(self : DbtxoptimisticVector, other : DbtxoptimisticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxoptimisticVector::norm(self : DbtxoptimisticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxoptimisticVector::normalize(self : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxoptimisticVector::dist(self : DbtxoptimisticVector, other : DbtxoptimisticVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxoptimisticVector::to_string(self : DbtxoptimisticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_optimistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_optimistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_optimistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_optimistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_optimistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_optimistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_optimistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_optimistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_optimistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_optimistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_optimistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_optimistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_optimistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_optimistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_optimistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_optimistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_optimistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_optimistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_optimistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_optimistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_optimistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_optimistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_optimistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_optimistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_optimistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_optimistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_optimistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_optimistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_optimistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxoptimisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_frame_make(size : Int) -> DbtxoptimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_frame_len(s : DbtxoptimisticFrame) -> Int { s.size }

pub fn db_tx_optimistic_frame_get(s : DbtxoptimisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_frame_set(s : DbtxoptimisticFrame, i : Int, v : Double) -> DbtxoptimisticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_frame_sum(s : DbtxoptimisticFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_frame_mean(s : DbtxoptimisticFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_frame_scale(s : DbtxoptimisticFrame, f : Double) -> DbtxoptimisticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_frame_add(a : DbtxoptimisticFrame, b : DbtxoptimisticFrame) -> DbtxoptimisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_frame_copy(s : DbtxoptimisticFrame) -> DbtxoptimisticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_frame_fill(s : DbtxoptimisticFrame, v : Double) -> DbtxoptimisticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_frame_min(s : DbtxoptimisticFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_frame_max(s : DbtxoptimisticFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_frame_to_string(s : DbtxoptimisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_table_make(size : Int) -> DbtxoptimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_table_len(s : DbtxoptimisticTable) -> Int { s.size }

pub fn db_tx_optimistic_table_get(s : DbtxoptimisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_table_set(s : DbtxoptimisticTable, i : Int, v : Double) -> DbtxoptimisticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_table_sum(s : DbtxoptimisticTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_table_mean(s : DbtxoptimisticTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_table_scale(s : DbtxoptimisticTable, f : Double) -> DbtxoptimisticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_table_add(a : DbtxoptimisticTable, b : DbtxoptimisticTable) -> DbtxoptimisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_table_copy(s : DbtxoptimisticTable) -> DbtxoptimisticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_table_fill(s : DbtxoptimisticTable, v : Double) -> DbtxoptimisticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_table_min(s : DbtxoptimisticTable) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_table_max(s : DbtxoptimisticTable) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_table_to_string(s : DbtxoptimisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_graphn_make(size : Int) -> DbtxoptimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_graphn_len(s : DbtxoptimisticGraphN) -> Int { s.size }

pub fn db_tx_optimistic_graphn_get(s : DbtxoptimisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_graphn_set(s : DbtxoptimisticGraphN, i : Int, v : Double) -> DbtxoptimisticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_graphn_sum(s : DbtxoptimisticGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_graphn_mean(s : DbtxoptimisticGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_graphn_scale(s : DbtxoptimisticGraphN, f : Double) -> DbtxoptimisticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_graphn_add(a : DbtxoptimisticGraphN, b : DbtxoptimisticGraphN) -> DbtxoptimisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_graphn_copy(s : DbtxoptimisticGraphN) -> DbtxoptimisticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_graphn_fill(s : DbtxoptimisticGraphN, v : Double) -> DbtxoptimisticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_graphn_min(s : DbtxoptimisticGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_graphn_max(s : DbtxoptimisticGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_graphn_to_string(s : DbtxoptimisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_node_make(size : Int) -> DbtxoptimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_node_len(s : DbtxoptimisticNode) -> Int { s.size }

pub fn db_tx_optimistic_node_get(s : DbtxoptimisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_node_set(s : DbtxoptimisticNode, i : Int, v : Double) -> DbtxoptimisticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_node_sum(s : DbtxoptimisticNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_node_mean(s : DbtxoptimisticNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_node_scale(s : DbtxoptimisticNode, f : Double) -> DbtxoptimisticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_node_add(a : DbtxoptimisticNode, b : DbtxoptimisticNode) -> DbtxoptimisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_node_copy(s : DbtxoptimisticNode) -> DbtxoptimisticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_node_fill(s : DbtxoptimisticNode, v : Double) -> DbtxoptimisticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_node_min(s : DbtxoptimisticNode) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_node_max(s : DbtxoptimisticNode) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_node_to_string(s : DbtxoptimisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_edge_make(size : Int) -> DbtxoptimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_edge_len(s : DbtxoptimisticEdge) -> Int { s.size }

pub fn db_tx_optimistic_edge_get(s : DbtxoptimisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_edge_set(s : DbtxoptimisticEdge, i : Int, v : Double) -> DbtxoptimisticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_edge_sum(s : DbtxoptimisticEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_edge_mean(s : DbtxoptimisticEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_edge_scale(s : DbtxoptimisticEdge, f : Double) -> DbtxoptimisticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_edge_add(a : DbtxoptimisticEdge, b : DbtxoptimisticEdge) -> DbtxoptimisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_edge_copy(s : DbtxoptimisticEdge) -> DbtxoptimisticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_edge_fill(s : DbtxoptimisticEdge, v : Double) -> DbtxoptimisticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_edge_min(s : DbtxoptimisticEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_edge_max(s : DbtxoptimisticEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_edge_to_string(s : DbtxoptimisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_path_make(size : Int) -> DbtxoptimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_path_len(s : DbtxoptimisticPath) -> Int { s.size }

pub fn db_tx_optimistic_path_get(s : DbtxoptimisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_path_set(s : DbtxoptimisticPath, i : Int, v : Double) -> DbtxoptimisticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_path_sum(s : DbtxoptimisticPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_path_mean(s : DbtxoptimisticPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_path_scale(s : DbtxoptimisticPath, f : Double) -> DbtxoptimisticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_path_add(a : DbtxoptimisticPath, b : DbtxoptimisticPath) -> DbtxoptimisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_path_copy(s : DbtxoptimisticPath) -> DbtxoptimisticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_path_fill(s : DbtxoptimisticPath, v : Double) -> DbtxoptimisticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_path_min(s : DbtxoptimisticPath) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_path_max(s : DbtxoptimisticPath) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_path_to_string(s : DbtxoptimisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_cluster_make(size : Int) -> DbtxoptimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_cluster_len(s : DbtxoptimisticCluster) -> Int { s.size }

pub fn db_tx_optimistic_cluster_get(s : DbtxoptimisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_cluster_set(s : DbtxoptimisticCluster, i : Int, v : Double) -> DbtxoptimisticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cluster_sum(s : DbtxoptimisticCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_cluster_mean(s : DbtxoptimisticCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_cluster_scale(s : DbtxoptimisticCluster, f : Double) -> DbtxoptimisticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cluster_add(a : DbtxoptimisticCluster, b : DbtxoptimisticCluster) -> DbtxoptimisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_cluster_copy(s : DbtxoptimisticCluster) -> DbtxoptimisticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cluster_fill(s : DbtxoptimisticCluster, v : Double) -> DbtxoptimisticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cluster_min(s : DbtxoptimisticCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_cluster_max(s : DbtxoptimisticCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_cluster_to_string(s : DbtxoptimisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_model_make(size : Int) -> DbtxoptimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_model_len(s : DbtxoptimisticModel) -> Int { s.size }

pub fn db_tx_optimistic_model_get(s : DbtxoptimisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_model_set(s : DbtxoptimisticModel, i : Int, v : Double) -> DbtxoptimisticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_model_sum(s : DbtxoptimisticModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_model_mean(s : DbtxoptimisticModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_model_scale(s : DbtxoptimisticModel, f : Double) -> DbtxoptimisticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_model_add(a : DbtxoptimisticModel, b : DbtxoptimisticModel) -> DbtxoptimisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_model_copy(s : DbtxoptimisticModel) -> DbtxoptimisticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_model_fill(s : DbtxoptimisticModel, v : Double) -> DbtxoptimisticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_model_min(s : DbtxoptimisticModel) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_model_max(s : DbtxoptimisticModel) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_model_to_string(s : DbtxoptimisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_layer_make(size : Int) -> DbtxoptimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_layer_len(s : DbtxoptimisticLayer) -> Int { s.size }

pub fn db_tx_optimistic_layer_get(s : DbtxoptimisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_layer_set(s : DbtxoptimisticLayer, i : Int, v : Double) -> DbtxoptimisticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_layer_sum(s : DbtxoptimisticLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_layer_mean(s : DbtxoptimisticLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_layer_scale(s : DbtxoptimisticLayer, f : Double) -> DbtxoptimisticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_layer_add(a : DbtxoptimisticLayer, b : DbtxoptimisticLayer) -> DbtxoptimisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_layer_copy(s : DbtxoptimisticLayer) -> DbtxoptimisticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_layer_fill(s : DbtxoptimisticLayer, v : Double) -> DbtxoptimisticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_layer_min(s : DbtxoptimisticLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_layer_max(s : DbtxoptimisticLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_layer_to_string(s : DbtxoptimisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_buffer_make(size : Int) -> DbtxoptimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_buffer_len(s : DbtxoptimisticBuffer) -> Int { s.size }

pub fn db_tx_optimistic_buffer_get(s : DbtxoptimisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_buffer_set(s : DbtxoptimisticBuffer, i : Int, v : Double) -> DbtxoptimisticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_buffer_sum(s : DbtxoptimisticBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_buffer_mean(s : DbtxoptimisticBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_buffer_scale(s : DbtxoptimisticBuffer, f : Double) -> DbtxoptimisticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_buffer_add(a : DbtxoptimisticBuffer, b : DbtxoptimisticBuffer) -> DbtxoptimisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_buffer_copy(s : DbtxoptimisticBuffer) -> DbtxoptimisticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_buffer_fill(s : DbtxoptimisticBuffer, v : Double) -> DbtxoptimisticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_buffer_min(s : DbtxoptimisticBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_buffer_max(s : DbtxoptimisticBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_buffer_to_string(s : DbtxoptimisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_cursor_make(size : Int) -> DbtxoptimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_cursor_len(s : DbtxoptimisticCursor) -> Int { s.size }

pub fn db_tx_optimistic_cursor_get(s : DbtxoptimisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_cursor_set(s : DbtxoptimisticCursor, i : Int, v : Double) -> DbtxoptimisticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cursor_sum(s : DbtxoptimisticCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_cursor_mean(s : DbtxoptimisticCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_cursor_scale(s : DbtxoptimisticCursor, f : Double) -> DbtxoptimisticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cursor_add(a : DbtxoptimisticCursor, b : DbtxoptimisticCursor) -> DbtxoptimisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_cursor_copy(s : DbtxoptimisticCursor) -> DbtxoptimisticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cursor_fill(s : DbtxoptimisticCursor, v : Double) -> DbtxoptimisticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_cursor_min(s : DbtxoptimisticCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_cursor_max(s : DbtxoptimisticCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_cursor_to_string(s : DbtxoptimisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_view_make(size : Int) -> DbtxoptimisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_view_len(s : DbtxoptimisticView) -> Int { s.size }

pub fn db_tx_optimistic_view_get(s : DbtxoptimisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_view_set(s : DbtxoptimisticView, i : Int, v : Double) -> DbtxoptimisticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_view_sum(s : DbtxoptimisticView) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_view_mean(s : DbtxoptimisticView) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_view_scale(s : DbtxoptimisticView, f : Double) -> DbtxoptimisticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_view_add(a : DbtxoptimisticView, b : DbtxoptimisticView) -> DbtxoptimisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_view_copy(s : DbtxoptimisticView) -> DbtxoptimisticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_view_fill(s : DbtxoptimisticView, v : Double) -> DbtxoptimisticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_view_min(s : DbtxoptimisticView) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_view_max(s : DbtxoptimisticView) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_view_to_string(s : DbtxoptimisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_range_make(size : Int) -> DbtxoptimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_range_len(s : DbtxoptimisticRange) -> Int { s.size }

pub fn db_tx_optimistic_range_get(s : DbtxoptimisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_range_set(s : DbtxoptimisticRange, i : Int, v : Double) -> DbtxoptimisticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_range_sum(s : DbtxoptimisticRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_range_mean(s : DbtxoptimisticRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_range_scale(s : DbtxoptimisticRange, f : Double) -> DbtxoptimisticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_range_add(a : DbtxoptimisticRange, b : DbtxoptimisticRange) -> DbtxoptimisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_range_copy(s : DbtxoptimisticRange) -> DbtxoptimisticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_range_fill(s : DbtxoptimisticRange, v : Double) -> DbtxoptimisticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_range_min(s : DbtxoptimisticRange) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_range_max(s : DbtxoptimisticRange) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_range_to_string(s : DbtxoptimisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_slice_make(size : Int) -> DbtxoptimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_slice_len(s : DbtxoptimisticSlice) -> Int { s.size }

pub fn db_tx_optimistic_slice_get(s : DbtxoptimisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_slice_set(s : DbtxoptimisticSlice, i : Int, v : Double) -> DbtxoptimisticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_slice_sum(s : DbtxoptimisticSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_slice_mean(s : DbtxoptimisticSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_slice_scale(s : DbtxoptimisticSlice, f : Double) -> DbtxoptimisticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_slice_add(a : DbtxoptimisticSlice, b : DbtxoptimisticSlice) -> DbtxoptimisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_optimistic_slice_copy(s : DbtxoptimisticSlice) -> DbtxoptimisticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_slice_fill(s : DbtxoptimisticSlice, v : Double) -> DbtxoptimisticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_optimistic_slice_min(s : DbtxoptimisticSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_slice_max(s : DbtxoptimisticSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_slice_to_string(s : DbtxoptimisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

