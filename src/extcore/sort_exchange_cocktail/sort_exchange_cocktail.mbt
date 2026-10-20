///===
/// extcore/sort_exchange_cocktail

pub(all) struct SortexchangecocktailPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_cocktail_make_point(x : Double, y : Double) -> SortexchangecocktailPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_cocktail_make_point3(x : Double, y : Double, z : Double) -> SortexchangecocktailPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangecocktailPoint::x(self : SortexchangecocktailPoint) -> Double { self.x }

pub fn SortexchangecocktailPoint::y(self : SortexchangecocktailPoint) -> Double { self.y }

pub fn SortexchangecocktailPoint::z(self : SortexchangecocktailPoint) -> Double { self.z }

pub fn SortexchangecocktailPoint::label(self : SortexchangecocktailPoint) -> Int { self.label }

pub fn SortexchangecocktailPoint::dist(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangecocktailPoint::add(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangecocktailPoint::sub(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangecocktailPoint::scale(self : SortexchangecocktailPoint, s : Double) -> SortexchangecocktailPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangecocktailPoint::dot(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangecocktailPoint::cross(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangecocktailPoint::norm(self : SortexchangecocktailPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangecocktailPoint::normalize(self : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangecocktailPoint::negate(self : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangecocktailPoint::mid(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangecocktailPoint::lerp(self : SortexchangecocktailPoint, other : SortexchangecocktailPoint, t : Double) -> SortexchangecocktailPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangecocktailPoint::to_string(self : SortexchangecocktailPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangecocktailSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_cocktail_make_series(vals : Array[Double], name : String) -> SortexchangecocktailSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangecocktailSeries::len(self : SortexchangecocktailSeries) -> Int { self.vals.length() }

pub fn SortexchangecocktailSeries::sum(self : SortexchangecocktailSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangecocktailSeries::mean(self : SortexchangecocktailSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangecocktailSeries::min(self : SortexchangecocktailSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangecocktailSeries::max(self : SortexchangecocktailSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangecocktailSeries::range(self : SortexchangecocktailSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangecocktailSeries::variance(self : SortexchangecocktailSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangecocktailSeries::std(self : SortexchangecocktailSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangecocktailSeries::median(self : SortexchangecocktailSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangecocktailSeries::scale(self : SortexchangecocktailSeries, f : Double) -> SortexchangecocktailSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangecocktailSeries::add(self : SortexchangecocktailSeries, other : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangecocktailSeries::sub(self : SortexchangecocktailSeries, other : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangecocktailSeries::normalize(self : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangecocktailSeries::cumsum(self : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangecocktailSeries::to_string(self : SortexchangecocktailSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangecocktailMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_cocktail_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangecocktailMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_cocktail_matrix_identity(n : Int) -> SortexchangecocktailMatrix {
  let m = sort_exchange_cocktail_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangecocktailMatrix::get(self : SortexchangecocktailMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangecocktailMatrix::transpose(self : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangecocktailMatrix::add(self : SortexchangecocktailMatrix, other : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_cocktail_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangecocktailMatrix::scale(self : SortexchangecocktailMatrix, s : Double) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangecocktailMatrix::multiply(self : SortexchangecocktailMatrix, other : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if self.cols != other.rows { return sort_exchange_cocktail_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_cocktail_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangecocktailMatrix::trace(self : SortexchangecocktailMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangecocktailMatrix::det(self : SortexchangecocktailMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangecocktailMatrix::norm(self : SortexchangecocktailMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangecocktailMatrix::to_string(self : SortexchangecocktailMatrix) -> String {
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

pub(all) struct SortexchangecocktailVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_cocktail_make_vector(comps : Array[Double]) -> SortexchangecocktailVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_cocktail_vector_zero(dim : Int) -> SortexchangecocktailVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangecocktailVector::add(self : SortexchangecocktailVector, other : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangecocktailVector::sub(self : SortexchangecocktailVector, other : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangecocktailVector::scale(self : SortexchangecocktailVector, s : Double) -> SortexchangecocktailVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangecocktailVector::dot(self : SortexchangecocktailVector, other : SortexchangecocktailVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangecocktailVector::norm(self : SortexchangecocktailVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangecocktailVector::normalize(self : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangecocktailVector::dist(self : SortexchangecocktailVector, other : SortexchangecocktailVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangecocktailVector::to_string(self : SortexchangecocktailVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_cocktail_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_cocktail_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_cocktail_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_cocktail_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_cocktail_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_cocktail_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_cocktail_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_cocktail_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_cocktail_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_cocktail_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_cocktail_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_cocktail_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_cocktail_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_cocktail_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_cocktail_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_cocktail_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_cocktail_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_cocktail_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_cocktail_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_cocktail_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_cocktail_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_cocktail_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_cocktail_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_cocktail_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_cocktail_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_cocktail_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_cocktail_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_cocktail_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_cocktail_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangecocktailFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_frame_make(size : Int) -> SortexchangecocktailFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_frame_len(s : SortexchangecocktailFrame) -> Int { s.size }

pub fn sort_exchange_cocktail_frame_get(s : SortexchangecocktailFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_frame_set(s : SortexchangecocktailFrame, i : Int, v : Double) -> SortexchangecocktailFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_sum(s : SortexchangecocktailFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_frame_mean(s : SortexchangecocktailFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_frame_scale(s : SortexchangecocktailFrame, f : Double) -> SortexchangecocktailFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_add(a : SortexchangecocktailFrame, b : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_frame_copy(s : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_fill(s : SortexchangecocktailFrame, v : Double) -> SortexchangecocktailFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_min(s : SortexchangecocktailFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_frame_max(s : SortexchangecocktailFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_frame_to_string(s : SortexchangecocktailFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_table_make(size : Int) -> SortexchangecocktailTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_table_len(s : SortexchangecocktailTable) -> Int { s.size }

pub fn sort_exchange_cocktail_table_get(s : SortexchangecocktailTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_table_set(s : SortexchangecocktailTable, i : Int, v : Double) -> SortexchangecocktailTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_sum(s : SortexchangecocktailTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_table_mean(s : SortexchangecocktailTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_table_scale(s : SortexchangecocktailTable, f : Double) -> SortexchangecocktailTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_add(a : SortexchangecocktailTable, b : SortexchangecocktailTable) -> SortexchangecocktailTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_table_copy(s : SortexchangecocktailTable) -> SortexchangecocktailTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_fill(s : SortexchangecocktailTable, v : Double) -> SortexchangecocktailTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_min(s : SortexchangecocktailTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_table_max(s : SortexchangecocktailTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_table_to_string(s : SortexchangecocktailTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_graphn_make(size : Int) -> SortexchangecocktailGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_graphn_len(s : SortexchangecocktailGraphN) -> Int { s.size }

pub fn sort_exchange_cocktail_graphn_get(s : SortexchangecocktailGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_graphn_set(s : SortexchangecocktailGraphN, i : Int, v : Double) -> SortexchangecocktailGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_sum(s : SortexchangecocktailGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_graphn_mean(s : SortexchangecocktailGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_graphn_scale(s : SortexchangecocktailGraphN, f : Double) -> SortexchangecocktailGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_add(a : SortexchangecocktailGraphN, b : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_graphn_copy(s : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_fill(s : SortexchangecocktailGraphN, v : Double) -> SortexchangecocktailGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_min(s : SortexchangecocktailGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_graphn_max(s : SortexchangecocktailGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_graphn_to_string(s : SortexchangecocktailGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_node_make(size : Int) -> SortexchangecocktailNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_node_len(s : SortexchangecocktailNode) -> Int { s.size }

pub fn sort_exchange_cocktail_node_get(s : SortexchangecocktailNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_node_set(s : SortexchangecocktailNode, i : Int, v : Double) -> SortexchangecocktailNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_sum(s : SortexchangecocktailNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_node_mean(s : SortexchangecocktailNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_node_scale(s : SortexchangecocktailNode, f : Double) -> SortexchangecocktailNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_add(a : SortexchangecocktailNode, b : SortexchangecocktailNode) -> SortexchangecocktailNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_node_copy(s : SortexchangecocktailNode) -> SortexchangecocktailNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_fill(s : SortexchangecocktailNode, v : Double) -> SortexchangecocktailNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_min(s : SortexchangecocktailNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_node_max(s : SortexchangecocktailNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_node_to_string(s : SortexchangecocktailNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_edge_make(size : Int) -> SortexchangecocktailEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_edge_len(s : SortexchangecocktailEdge) -> Int { s.size }

pub fn sort_exchange_cocktail_edge_get(s : SortexchangecocktailEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_edge_set(s : SortexchangecocktailEdge, i : Int, v : Double) -> SortexchangecocktailEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_sum(s : SortexchangecocktailEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_edge_mean(s : SortexchangecocktailEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_edge_scale(s : SortexchangecocktailEdge, f : Double) -> SortexchangecocktailEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_add(a : SortexchangecocktailEdge, b : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_edge_copy(s : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_fill(s : SortexchangecocktailEdge, v : Double) -> SortexchangecocktailEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_min(s : SortexchangecocktailEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_edge_max(s : SortexchangecocktailEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_edge_to_string(s : SortexchangecocktailEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_path_make(size : Int) -> SortexchangecocktailPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_path_len(s : SortexchangecocktailPath) -> Int { s.size }

pub fn sort_exchange_cocktail_path_get(s : SortexchangecocktailPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_path_set(s : SortexchangecocktailPath, i : Int, v : Double) -> SortexchangecocktailPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_sum(s : SortexchangecocktailPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_path_mean(s : SortexchangecocktailPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_path_scale(s : SortexchangecocktailPath, f : Double) -> SortexchangecocktailPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_add(a : SortexchangecocktailPath, b : SortexchangecocktailPath) -> SortexchangecocktailPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_path_copy(s : SortexchangecocktailPath) -> SortexchangecocktailPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_fill(s : SortexchangecocktailPath, v : Double) -> SortexchangecocktailPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_min(s : SortexchangecocktailPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_path_max(s : SortexchangecocktailPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_path_to_string(s : SortexchangecocktailPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cluster_make(size : Int) -> SortexchangecocktailCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cluster_len(s : SortexchangecocktailCluster) -> Int { s.size }

pub fn sort_exchange_cocktail_cluster_get(s : SortexchangecocktailCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cluster_set(s : SortexchangecocktailCluster, i : Int, v : Double) -> SortexchangecocktailCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_sum(s : SortexchangecocktailCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_cluster_mean(s : SortexchangecocktailCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_cluster_scale(s : SortexchangecocktailCluster, f : Double) -> SortexchangecocktailCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_add(a : SortexchangecocktailCluster, b : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_cluster_copy(s : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_fill(s : SortexchangecocktailCluster, v : Double) -> SortexchangecocktailCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_min(s : SortexchangecocktailCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_cluster_max(s : SortexchangecocktailCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_cluster_to_string(s : SortexchangecocktailCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_model_make(size : Int) -> SortexchangecocktailModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_model_len(s : SortexchangecocktailModel) -> Int { s.size }

pub fn sort_exchange_cocktail_model_get(s : SortexchangecocktailModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_model_set(s : SortexchangecocktailModel, i : Int, v : Double) -> SortexchangecocktailModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_sum(s : SortexchangecocktailModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_model_mean(s : SortexchangecocktailModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_model_scale(s : SortexchangecocktailModel, f : Double) -> SortexchangecocktailModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_add(a : SortexchangecocktailModel, b : SortexchangecocktailModel) -> SortexchangecocktailModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_model_copy(s : SortexchangecocktailModel) -> SortexchangecocktailModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_fill(s : SortexchangecocktailModel, v : Double) -> SortexchangecocktailModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_min(s : SortexchangecocktailModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_model_max(s : SortexchangecocktailModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_model_to_string(s : SortexchangecocktailModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_layer_make(size : Int) -> SortexchangecocktailLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_layer_len(s : SortexchangecocktailLayer) -> Int { s.size }

pub fn sort_exchange_cocktail_layer_get(s : SortexchangecocktailLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_layer_set(s : SortexchangecocktailLayer, i : Int, v : Double) -> SortexchangecocktailLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_sum(s : SortexchangecocktailLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_layer_mean(s : SortexchangecocktailLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_layer_scale(s : SortexchangecocktailLayer, f : Double) -> SortexchangecocktailLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_add(a : SortexchangecocktailLayer, b : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_layer_copy(s : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_fill(s : SortexchangecocktailLayer, v : Double) -> SortexchangecocktailLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_min(s : SortexchangecocktailLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_layer_max(s : SortexchangecocktailLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_layer_to_string(s : SortexchangecocktailLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_buffer_make(size : Int) -> SortexchangecocktailBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_buffer_len(s : SortexchangecocktailBuffer) -> Int { s.size }

pub fn sort_exchange_cocktail_buffer_get(s : SortexchangecocktailBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_buffer_set(s : SortexchangecocktailBuffer, i : Int, v : Double) -> SortexchangecocktailBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_sum(s : SortexchangecocktailBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_buffer_mean(s : SortexchangecocktailBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_buffer_scale(s : SortexchangecocktailBuffer, f : Double) -> SortexchangecocktailBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_add(a : SortexchangecocktailBuffer, b : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_buffer_copy(s : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_fill(s : SortexchangecocktailBuffer, v : Double) -> SortexchangecocktailBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_min(s : SortexchangecocktailBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_buffer_max(s : SortexchangecocktailBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_buffer_to_string(s : SortexchangecocktailBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cursor_make(size : Int) -> SortexchangecocktailCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cursor_len(s : SortexchangecocktailCursor) -> Int { s.size }

pub fn sort_exchange_cocktail_cursor_get(s : SortexchangecocktailCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cursor_set(s : SortexchangecocktailCursor, i : Int, v : Double) -> SortexchangecocktailCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_sum(s : SortexchangecocktailCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_cursor_mean(s : SortexchangecocktailCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_cursor_scale(s : SortexchangecocktailCursor, f : Double) -> SortexchangecocktailCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_add(a : SortexchangecocktailCursor, b : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_cursor_copy(s : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_fill(s : SortexchangecocktailCursor, v : Double) -> SortexchangecocktailCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_min(s : SortexchangecocktailCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_cursor_max(s : SortexchangecocktailCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_cursor_to_string(s : SortexchangecocktailCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_view_make(size : Int) -> SortexchangecocktailView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_view_len(s : SortexchangecocktailView) -> Int { s.size }

pub fn sort_exchange_cocktail_view_get(s : SortexchangecocktailView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_view_set(s : SortexchangecocktailView, i : Int, v : Double) -> SortexchangecocktailView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_sum(s : SortexchangecocktailView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_view_mean(s : SortexchangecocktailView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_view_scale(s : SortexchangecocktailView, f : Double) -> SortexchangecocktailView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_add(a : SortexchangecocktailView, b : SortexchangecocktailView) -> SortexchangecocktailView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_view_copy(s : SortexchangecocktailView) -> SortexchangecocktailView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_fill(s : SortexchangecocktailView, v : Double) -> SortexchangecocktailView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_min(s : SortexchangecocktailView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_view_max(s : SortexchangecocktailView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_view_to_string(s : SortexchangecocktailView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_range_make(size : Int) -> SortexchangecocktailRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_range_len(s : SortexchangecocktailRange) -> Int { s.size }

pub fn sort_exchange_cocktail_range_get(s : SortexchangecocktailRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_range_set(s : SortexchangecocktailRange, i : Int, v : Double) -> SortexchangecocktailRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_sum(s : SortexchangecocktailRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_range_mean(s : SortexchangecocktailRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_range_scale(s : SortexchangecocktailRange, f : Double) -> SortexchangecocktailRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_add(a : SortexchangecocktailRange, b : SortexchangecocktailRange) -> SortexchangecocktailRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_range_copy(s : SortexchangecocktailRange) -> SortexchangecocktailRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_fill(s : SortexchangecocktailRange, v : Double) -> SortexchangecocktailRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_min(s : SortexchangecocktailRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_range_max(s : SortexchangecocktailRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_range_to_string(s : SortexchangecocktailRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_slice_make(size : Int) -> SortexchangecocktailSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_slice_len(s : SortexchangecocktailSlice) -> Int { s.size }

pub fn sort_exchange_cocktail_slice_get(s : SortexchangecocktailSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_slice_set(s : SortexchangecocktailSlice, i : Int, v : Double) -> SortexchangecocktailSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_sum(s : SortexchangecocktailSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_slice_mean(s : SortexchangecocktailSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_slice_scale(s : SortexchangecocktailSlice, f : Double) -> SortexchangecocktailSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_add(a : SortexchangecocktailSlice, b : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_slice_copy(s : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_fill(s : SortexchangecocktailSlice, v : Double) -> SortexchangecocktailSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_min(s : SortexchangecocktailSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_slice_max(s : SortexchangecocktailSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_slice_to_string(s : SortexchangecocktailSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

