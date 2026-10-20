///===
/// extcore/ml_feature_umap

pub(all) struct MlfeatureumapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_umap_make_point(x : Double, y : Double) -> MlfeatureumapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_umap_make_point3(x : Double, y : Double, z : Double) -> MlfeatureumapPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureumapPoint::x(self : MlfeatureumapPoint) -> Double { self.x }

pub fn MlfeatureumapPoint::y(self : MlfeatureumapPoint) -> Double { self.y }

pub fn MlfeatureumapPoint::z(self : MlfeatureumapPoint) -> Double { self.z }

pub fn MlfeatureumapPoint::label(self : MlfeatureumapPoint) -> Int { self.label }

pub fn MlfeatureumapPoint::dist(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureumapPoint::add(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureumapPoint::sub(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureumapPoint::scale(self : MlfeatureumapPoint, s : Double) -> MlfeatureumapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureumapPoint::dot(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureumapPoint::cross(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureumapPoint::norm(self : MlfeatureumapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureumapPoint::normalize(self : MlfeatureumapPoint) -> MlfeatureumapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureumapPoint::negate(self : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureumapPoint::mid(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureumapPoint::lerp(self : MlfeatureumapPoint, other : MlfeatureumapPoint, t : Double) -> MlfeatureumapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureumapPoint::to_string(self : MlfeatureumapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureumapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_umap_make_series(vals : Array[Double], name : String) -> MlfeatureumapSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureumapSeries::len(self : MlfeatureumapSeries) -> Int { self.vals.length() }

pub fn MlfeatureumapSeries::sum(self : MlfeatureumapSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureumapSeries::mean(self : MlfeatureumapSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureumapSeries::min(self : MlfeatureumapSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureumapSeries::max(self : MlfeatureumapSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureumapSeries::range(self : MlfeatureumapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureumapSeries::variance(self : MlfeatureumapSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureumapSeries::std(self : MlfeatureumapSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureumapSeries::median(self : MlfeatureumapSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureumapSeries::scale(self : MlfeatureumapSeries, f : Double) -> MlfeatureumapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::add(self : MlfeatureumapSeries, other : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::sub(self : MlfeatureumapSeries, other : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::normalize(self : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureumapSeries::cumsum(self : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureumapSeries::to_string(self : MlfeatureumapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureumapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_umap_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureumapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_umap_matrix_identity(n : Int) -> MlfeatureumapMatrix {
  let m = ml_feature_umap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureumapMatrix::get(self : MlfeatureumapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureumapMatrix::transpose(self : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureumapMatrix::add(self : MlfeatureumapMatrix, other : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_umap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureumapMatrix::scale(self : MlfeatureumapMatrix, s : Double) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureumapMatrix::multiply(self : MlfeatureumapMatrix, other : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if self.cols != other.rows { return ml_feature_umap_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_umap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureumapMatrix::trace(self : MlfeatureumapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureumapMatrix::det(self : MlfeatureumapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureumapMatrix::norm(self : MlfeatureumapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureumapMatrix::to_string(self : MlfeatureumapMatrix) -> String {
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

pub(all) struct MlfeatureumapVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_umap_make_vector(comps : Array[Double]) -> MlfeatureumapVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_umap_vector_zero(dim : Int) -> MlfeatureumapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureumapVector::add(self : MlfeatureumapVector, other : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureumapVector::sub(self : MlfeatureumapVector, other : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureumapVector::scale(self : MlfeatureumapVector, s : Double) -> MlfeatureumapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureumapVector::dot(self : MlfeatureumapVector, other : MlfeatureumapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureumapVector::norm(self : MlfeatureumapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureumapVector::normalize(self : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureumapVector::dist(self : MlfeatureumapVector, other : MlfeatureumapVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureumapVector::to_string(self : MlfeatureumapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_umap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_umap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_umap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_umap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_umap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_umap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_umap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_umap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_umap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_umap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_umap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_umap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_umap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_umap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_umap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_umap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_umap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_umap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_umap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_umap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_umap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_umap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_umap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_umap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_umap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_umap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_umap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_umap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_umap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureumapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_frame_make(size : Int) -> MlfeatureumapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapFrame::len(self : MlfeatureumapFrame) -> Int { self.size }

pub fn MlfeatureumapFrame::get(self : MlfeatureumapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapFrame::set(self : MlfeatureumapFrame, i : Int, v : Double) -> MlfeatureumapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapFrame::sum(self : MlfeatureumapFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapFrame::mean(self : MlfeatureumapFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapFrame::scale(self : MlfeatureumapFrame, f : Double) -> MlfeatureumapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapFrame::add(self : MlfeatureumapFrame, other : MlfeatureumapFrame) -> MlfeatureumapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapFrame::copy(self : MlfeatureumapFrame) -> MlfeatureumapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapFrame::fill(self : MlfeatureumapFrame, v : Double) -> MlfeatureumapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapFrame::min(self : MlfeatureumapFrame) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapFrame::max(self : MlfeatureumapFrame) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapFrame::to_string(self : MlfeatureumapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_table_make(size : Int) -> MlfeatureumapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapTable::len(self : MlfeatureumapTable) -> Int { self.size }

pub fn MlfeatureumapTable::get(self : MlfeatureumapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapTable::set(self : MlfeatureumapTable, i : Int, v : Double) -> MlfeatureumapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapTable::sum(self : MlfeatureumapTable) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapTable::mean(self : MlfeatureumapTable) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapTable::scale(self : MlfeatureumapTable, f : Double) -> MlfeatureumapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapTable::add(self : MlfeatureumapTable, other : MlfeatureumapTable) -> MlfeatureumapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapTable::copy(self : MlfeatureumapTable) -> MlfeatureumapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapTable::fill(self : MlfeatureumapTable, v : Double) -> MlfeatureumapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapTable::min(self : MlfeatureumapTable) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapTable::max(self : MlfeatureumapTable) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapTable::to_string(self : MlfeatureumapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_graphn_make(size : Int) -> MlfeatureumapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapGraphN::len(self : MlfeatureumapGraphN) -> Int { self.size }

pub fn MlfeatureumapGraphN::get(self : MlfeatureumapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapGraphN::set(self : MlfeatureumapGraphN, i : Int, v : Double) -> MlfeatureumapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapGraphN::sum(self : MlfeatureumapGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapGraphN::mean(self : MlfeatureumapGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapGraphN::scale(self : MlfeatureumapGraphN, f : Double) -> MlfeatureumapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapGraphN::add(self : MlfeatureumapGraphN, other : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapGraphN::copy(self : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapGraphN::fill(self : MlfeatureumapGraphN, v : Double) -> MlfeatureumapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapGraphN::min(self : MlfeatureumapGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapGraphN::max(self : MlfeatureumapGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapGraphN::to_string(self : MlfeatureumapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_node_make(size : Int) -> MlfeatureumapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapNode::len(self : MlfeatureumapNode) -> Int { self.size }

pub fn MlfeatureumapNode::get(self : MlfeatureumapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapNode::set(self : MlfeatureumapNode, i : Int, v : Double) -> MlfeatureumapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapNode::sum(self : MlfeatureumapNode) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapNode::mean(self : MlfeatureumapNode) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapNode::scale(self : MlfeatureumapNode, f : Double) -> MlfeatureumapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapNode::add(self : MlfeatureumapNode, other : MlfeatureumapNode) -> MlfeatureumapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapNode::copy(self : MlfeatureumapNode) -> MlfeatureumapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapNode::fill(self : MlfeatureumapNode, v : Double) -> MlfeatureumapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapNode::min(self : MlfeatureumapNode) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapNode::max(self : MlfeatureumapNode) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapNode::to_string(self : MlfeatureumapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_edge_make(size : Int) -> MlfeatureumapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapEdge::len(self : MlfeatureumapEdge) -> Int { self.size }

pub fn MlfeatureumapEdge::get(self : MlfeatureumapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapEdge::set(self : MlfeatureumapEdge, i : Int, v : Double) -> MlfeatureumapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapEdge::sum(self : MlfeatureumapEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapEdge::mean(self : MlfeatureumapEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapEdge::scale(self : MlfeatureumapEdge, f : Double) -> MlfeatureumapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapEdge::add(self : MlfeatureumapEdge, other : MlfeatureumapEdge) -> MlfeatureumapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapEdge::copy(self : MlfeatureumapEdge) -> MlfeatureumapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapEdge::fill(self : MlfeatureumapEdge, v : Double) -> MlfeatureumapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapEdge::min(self : MlfeatureumapEdge) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapEdge::max(self : MlfeatureumapEdge) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapEdge::to_string(self : MlfeatureumapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_path_make(size : Int) -> MlfeatureumapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapPath::len(self : MlfeatureumapPath) -> Int { self.size }

pub fn MlfeatureumapPath::get(self : MlfeatureumapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapPath::set(self : MlfeatureumapPath, i : Int, v : Double) -> MlfeatureumapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapPath::sum(self : MlfeatureumapPath) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapPath::mean(self : MlfeatureumapPath) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapPath::scale(self : MlfeatureumapPath, f : Double) -> MlfeatureumapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapPath::add(self : MlfeatureumapPath, other : MlfeatureumapPath) -> MlfeatureumapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapPath::copy(self : MlfeatureumapPath) -> MlfeatureumapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapPath::fill(self : MlfeatureumapPath, v : Double) -> MlfeatureumapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapPath::min(self : MlfeatureumapPath) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapPath::max(self : MlfeatureumapPath) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapPath::to_string(self : MlfeatureumapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cluster_make(size : Int) -> MlfeatureumapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapCluster::len(self : MlfeatureumapCluster) -> Int { self.size }

pub fn MlfeatureumapCluster::get(self : MlfeatureumapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapCluster::set(self : MlfeatureumapCluster, i : Int, v : Double) -> MlfeatureumapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCluster::sum(self : MlfeatureumapCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapCluster::mean(self : MlfeatureumapCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapCluster::scale(self : MlfeatureumapCluster, f : Double) -> MlfeatureumapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCluster::add(self : MlfeatureumapCluster, other : MlfeatureumapCluster) -> MlfeatureumapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapCluster::copy(self : MlfeatureumapCluster) -> MlfeatureumapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCluster::fill(self : MlfeatureumapCluster, v : Double) -> MlfeatureumapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCluster::min(self : MlfeatureumapCluster) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapCluster::max(self : MlfeatureumapCluster) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapCluster::to_string(self : MlfeatureumapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_model_make(size : Int) -> MlfeatureumapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapModel::len(self : MlfeatureumapModel) -> Int { self.size }

pub fn MlfeatureumapModel::get(self : MlfeatureumapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapModel::set(self : MlfeatureumapModel, i : Int, v : Double) -> MlfeatureumapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapModel::sum(self : MlfeatureumapModel) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapModel::mean(self : MlfeatureumapModel) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapModel::scale(self : MlfeatureumapModel, f : Double) -> MlfeatureumapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapModel::add(self : MlfeatureumapModel, other : MlfeatureumapModel) -> MlfeatureumapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapModel::copy(self : MlfeatureumapModel) -> MlfeatureumapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapModel::fill(self : MlfeatureumapModel, v : Double) -> MlfeatureumapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapModel::min(self : MlfeatureumapModel) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapModel::max(self : MlfeatureumapModel) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapModel::to_string(self : MlfeatureumapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_layer_make(size : Int) -> MlfeatureumapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapLayer::len(self : MlfeatureumapLayer) -> Int { self.size }

pub fn MlfeatureumapLayer::get(self : MlfeatureumapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapLayer::set(self : MlfeatureumapLayer, i : Int, v : Double) -> MlfeatureumapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapLayer::sum(self : MlfeatureumapLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapLayer::mean(self : MlfeatureumapLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapLayer::scale(self : MlfeatureumapLayer, f : Double) -> MlfeatureumapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapLayer::add(self : MlfeatureumapLayer, other : MlfeatureumapLayer) -> MlfeatureumapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapLayer::copy(self : MlfeatureumapLayer) -> MlfeatureumapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapLayer::fill(self : MlfeatureumapLayer, v : Double) -> MlfeatureumapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapLayer::min(self : MlfeatureumapLayer) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapLayer::max(self : MlfeatureumapLayer) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapLayer::to_string(self : MlfeatureumapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_buffer_make(size : Int) -> MlfeatureumapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapBuffer::len(self : MlfeatureumapBuffer) -> Int { self.size }

pub fn MlfeatureumapBuffer::get(self : MlfeatureumapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapBuffer::set(self : MlfeatureumapBuffer, i : Int, v : Double) -> MlfeatureumapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapBuffer::sum(self : MlfeatureumapBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapBuffer::mean(self : MlfeatureumapBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapBuffer::scale(self : MlfeatureumapBuffer, f : Double) -> MlfeatureumapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapBuffer::add(self : MlfeatureumapBuffer, other : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapBuffer::copy(self : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapBuffer::fill(self : MlfeatureumapBuffer, v : Double) -> MlfeatureumapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapBuffer::min(self : MlfeatureumapBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapBuffer::max(self : MlfeatureumapBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapBuffer::to_string(self : MlfeatureumapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cursor_make(size : Int) -> MlfeatureumapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapCursor::len(self : MlfeatureumapCursor) -> Int { self.size }

pub fn MlfeatureumapCursor::get(self : MlfeatureumapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapCursor::set(self : MlfeatureumapCursor, i : Int, v : Double) -> MlfeatureumapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCursor::sum(self : MlfeatureumapCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapCursor::mean(self : MlfeatureumapCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapCursor::scale(self : MlfeatureumapCursor, f : Double) -> MlfeatureumapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCursor::add(self : MlfeatureumapCursor, other : MlfeatureumapCursor) -> MlfeatureumapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapCursor::copy(self : MlfeatureumapCursor) -> MlfeatureumapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCursor::fill(self : MlfeatureumapCursor, v : Double) -> MlfeatureumapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapCursor::min(self : MlfeatureumapCursor) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapCursor::max(self : MlfeatureumapCursor) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapCursor::to_string(self : MlfeatureumapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_view_make(size : Int) -> MlfeatureumapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapView::len(self : MlfeatureumapView) -> Int { self.size }

pub fn MlfeatureumapView::get(self : MlfeatureumapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapView::set(self : MlfeatureumapView, i : Int, v : Double) -> MlfeatureumapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapView::sum(self : MlfeatureumapView) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapView::mean(self : MlfeatureumapView) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapView::scale(self : MlfeatureumapView, f : Double) -> MlfeatureumapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapView::add(self : MlfeatureumapView, other : MlfeatureumapView) -> MlfeatureumapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapView::copy(self : MlfeatureumapView) -> MlfeatureumapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapView::fill(self : MlfeatureumapView, v : Double) -> MlfeatureumapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapView::min(self : MlfeatureumapView) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapView::max(self : MlfeatureumapView) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapView::to_string(self : MlfeatureumapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_range_make(size : Int) -> MlfeatureumapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapRange::len(self : MlfeatureumapRange) -> Int { self.size }

pub fn MlfeatureumapRange::get(self : MlfeatureumapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapRange::set(self : MlfeatureumapRange, i : Int, v : Double) -> MlfeatureumapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapRange::sum(self : MlfeatureumapRange) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapRange::mean(self : MlfeatureumapRange) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapRange::scale(self : MlfeatureumapRange, f : Double) -> MlfeatureumapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapRange::add(self : MlfeatureumapRange, other : MlfeatureumapRange) -> MlfeatureumapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapRange::copy(self : MlfeatureumapRange) -> MlfeatureumapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapRange::fill(self : MlfeatureumapRange, v : Double) -> MlfeatureumapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapRange::min(self : MlfeatureumapRange) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapRange::max(self : MlfeatureumapRange) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapRange::to_string(self : MlfeatureumapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_slice_make(size : Int) -> MlfeatureumapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureumapSlice::len(self : MlfeatureumapSlice) -> Int { self.size }

pub fn MlfeatureumapSlice::get(self : MlfeatureumapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureumapSlice::set(self : MlfeatureumapSlice, i : Int, v : Double) -> MlfeatureumapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureumapSlice::sum(self : MlfeatureumapSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeatureumapSlice::mean(self : MlfeatureumapSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeatureumapSlice::scale(self : MlfeatureumapSlice, f : Double) -> MlfeatureumapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapSlice::add(self : MlfeatureumapSlice, other : MlfeatureumapSlice) -> MlfeatureumapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureumapSlice::copy(self : MlfeatureumapSlice) -> MlfeatureumapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapSlice::fill(self : MlfeatureumapSlice, v : Double) -> MlfeatureumapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureumapSlice::min(self : MlfeatureumapSlice) -> Double { @_common.min(self.data) }

pub fn MlfeatureumapSlice::max(self : MlfeatureumapSlice) -> Double { @_common.max(self.data) }

pub fn MlfeatureumapSlice::to_string(self : MlfeatureumapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

