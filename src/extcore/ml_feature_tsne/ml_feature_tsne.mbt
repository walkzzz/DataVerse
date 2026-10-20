///===
/// extcore/ml_feature_tsne

pub(all) struct MlfeaturetsnePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_tsne_make_point(x : Double, y : Double) -> MlfeaturetsnePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_tsne_make_point3(x : Double, y : Double, z : Double) -> MlfeaturetsnePoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturetsnePoint::x(self : MlfeaturetsnePoint) -> Double { self.x }

pub fn MlfeaturetsnePoint::y(self : MlfeaturetsnePoint) -> Double { self.y }

pub fn MlfeaturetsnePoint::z(self : MlfeaturetsnePoint) -> Double { self.z }

pub fn MlfeaturetsnePoint::label(self : MlfeaturetsnePoint) -> Int { self.label }

pub fn MlfeaturetsnePoint::dist(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturetsnePoint::add(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturetsnePoint::sub(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturetsnePoint::scale(self : MlfeaturetsnePoint, s : Double) -> MlfeaturetsnePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturetsnePoint::dot(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturetsnePoint::cross(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturetsnePoint::norm(self : MlfeaturetsnePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturetsnePoint::normalize(self : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturetsnePoint::negate(self : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturetsnePoint::mid(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturetsnePoint::lerp(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint, t : Double) -> MlfeaturetsnePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturetsnePoint::to_string(self : MlfeaturetsnePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturetsneSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_tsne_make_series(vals : Array[Double], name : String) -> MlfeaturetsneSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturetsneSeries::len(self : MlfeaturetsneSeries) -> Int { self.vals.length() }

pub fn MlfeaturetsneSeries::sum(self : MlfeaturetsneSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturetsneSeries::mean(self : MlfeaturetsneSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturetsneSeries::min(self : MlfeaturetsneSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturetsneSeries::max(self : MlfeaturetsneSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturetsneSeries::range(self : MlfeaturetsneSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturetsneSeries::variance(self : MlfeaturetsneSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturetsneSeries::std(self : MlfeaturetsneSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturetsneSeries::median(self : MlfeaturetsneSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturetsneSeries::scale(self : MlfeaturetsneSeries, f : Double) -> MlfeaturetsneSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::add(self : MlfeaturetsneSeries, other : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::sub(self : MlfeaturetsneSeries, other : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::normalize(self : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturetsneSeries::cumsum(self : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturetsneSeries::to_string(self : MlfeaturetsneSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturetsneMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_tsne_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturetsneMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_tsne_matrix_identity(n : Int) -> MlfeaturetsneMatrix {
  let m = ml_feature_tsne_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturetsneMatrix::get(self : MlfeaturetsneMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturetsneMatrix::transpose(self : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  let result = ml_feature_tsne_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturetsneMatrix::add(self : MlfeaturetsneMatrix, other : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_tsne_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturetsneMatrix::scale(self : MlfeaturetsneMatrix, s : Double) -> MlfeaturetsneMatrix {
  let result = ml_feature_tsne_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturetsneMatrix::multiply(self : MlfeaturetsneMatrix, other : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  if self.cols != other.rows { return ml_feature_tsne_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_tsne_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturetsneMatrix::trace(self : MlfeaturetsneMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturetsneMatrix::det(self : MlfeaturetsneMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturetsneMatrix::norm(self : MlfeaturetsneMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturetsneMatrix::to_string(self : MlfeaturetsneMatrix) -> String {
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

pub(all) struct MlfeaturetsneVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_tsne_make_vector(comps : Array[Double]) -> MlfeaturetsneVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_tsne_vector_zero(dim : Int) -> MlfeaturetsneVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturetsneVector::add(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturetsneVector::sub(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturetsneVector::scale(self : MlfeaturetsneVector, s : Double) -> MlfeaturetsneVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturetsneVector::dot(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturetsneVector::norm(self : MlfeaturetsneVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturetsneVector::normalize(self : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturetsneVector::dist(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturetsneVector::to_string(self : MlfeaturetsneVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_tsne_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_tsne_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_tsne_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_tsne_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_tsne_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_tsne_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_tsne_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_tsne_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_tsne_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_tsne_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_tsne_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_tsne_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_tsne_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_tsne_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_tsne_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_tsne_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_tsne_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_tsne_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_tsne_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_tsne_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_tsne_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_tsne_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_tsne_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_tsne_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_tsne_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_tsne_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_tsne_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_tsne_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_tsne_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturetsneFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_frame_make(size : Int) -> MlfeaturetsneFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneFrame::len(self : MlfeaturetsneFrame) -> Int { self.size }

pub fn MlfeaturetsneFrame::get(self : MlfeaturetsneFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneFrame::set(self : MlfeaturetsneFrame, i : Int, v : Double) -> MlfeaturetsneFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneFrame::sum(self : MlfeaturetsneFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneFrame::mean(self : MlfeaturetsneFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneFrame::scale(self : MlfeaturetsneFrame, f : Double) -> MlfeaturetsneFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneFrame::add(self : MlfeaturetsneFrame, other : MlfeaturetsneFrame) -> MlfeaturetsneFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneFrame::copy(self : MlfeaturetsneFrame) -> MlfeaturetsneFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneFrame::fill(self : MlfeaturetsneFrame, v : Double) -> MlfeaturetsneFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneFrame::min(self : MlfeaturetsneFrame) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneFrame::max(self : MlfeaturetsneFrame) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneFrame::to_string(self : MlfeaturetsneFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_table_make(size : Int) -> MlfeaturetsneTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneTable::len(self : MlfeaturetsneTable) -> Int { self.size }

pub fn MlfeaturetsneTable::get(self : MlfeaturetsneTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneTable::set(self : MlfeaturetsneTable, i : Int, v : Double) -> MlfeaturetsneTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneTable::sum(self : MlfeaturetsneTable) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneTable::mean(self : MlfeaturetsneTable) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneTable::scale(self : MlfeaturetsneTable, f : Double) -> MlfeaturetsneTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneTable::add(self : MlfeaturetsneTable, other : MlfeaturetsneTable) -> MlfeaturetsneTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneTable::copy(self : MlfeaturetsneTable) -> MlfeaturetsneTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneTable::fill(self : MlfeaturetsneTable, v : Double) -> MlfeaturetsneTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneTable::min(self : MlfeaturetsneTable) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneTable::max(self : MlfeaturetsneTable) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneTable::to_string(self : MlfeaturetsneTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_graphn_make(size : Int) -> MlfeaturetsneGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneGraphN::len(self : MlfeaturetsneGraphN) -> Int { self.size }

pub fn MlfeaturetsneGraphN::get(self : MlfeaturetsneGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneGraphN::set(self : MlfeaturetsneGraphN, i : Int, v : Double) -> MlfeaturetsneGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneGraphN::sum(self : MlfeaturetsneGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneGraphN::mean(self : MlfeaturetsneGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneGraphN::scale(self : MlfeaturetsneGraphN, f : Double) -> MlfeaturetsneGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneGraphN::add(self : MlfeaturetsneGraphN, other : MlfeaturetsneGraphN) -> MlfeaturetsneGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneGraphN::copy(self : MlfeaturetsneGraphN) -> MlfeaturetsneGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneGraphN::fill(self : MlfeaturetsneGraphN, v : Double) -> MlfeaturetsneGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneGraphN::min(self : MlfeaturetsneGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneGraphN::max(self : MlfeaturetsneGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneGraphN::to_string(self : MlfeaturetsneGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_node_make(size : Int) -> MlfeaturetsneNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneNode::len(self : MlfeaturetsneNode) -> Int { self.size }

pub fn MlfeaturetsneNode::get(self : MlfeaturetsneNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneNode::set(self : MlfeaturetsneNode, i : Int, v : Double) -> MlfeaturetsneNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneNode::sum(self : MlfeaturetsneNode) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneNode::mean(self : MlfeaturetsneNode) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneNode::scale(self : MlfeaturetsneNode, f : Double) -> MlfeaturetsneNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneNode::add(self : MlfeaturetsneNode, other : MlfeaturetsneNode) -> MlfeaturetsneNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneNode::copy(self : MlfeaturetsneNode) -> MlfeaturetsneNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneNode::fill(self : MlfeaturetsneNode, v : Double) -> MlfeaturetsneNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneNode::min(self : MlfeaturetsneNode) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneNode::max(self : MlfeaturetsneNode) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneNode::to_string(self : MlfeaturetsneNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_edge_make(size : Int) -> MlfeaturetsneEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneEdge::len(self : MlfeaturetsneEdge) -> Int { self.size }

pub fn MlfeaturetsneEdge::get(self : MlfeaturetsneEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneEdge::set(self : MlfeaturetsneEdge, i : Int, v : Double) -> MlfeaturetsneEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneEdge::sum(self : MlfeaturetsneEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneEdge::mean(self : MlfeaturetsneEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneEdge::scale(self : MlfeaturetsneEdge, f : Double) -> MlfeaturetsneEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneEdge::add(self : MlfeaturetsneEdge, other : MlfeaturetsneEdge) -> MlfeaturetsneEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneEdge::copy(self : MlfeaturetsneEdge) -> MlfeaturetsneEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneEdge::fill(self : MlfeaturetsneEdge, v : Double) -> MlfeaturetsneEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneEdge::min(self : MlfeaturetsneEdge) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneEdge::max(self : MlfeaturetsneEdge) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneEdge::to_string(self : MlfeaturetsneEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsnePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_path_make(size : Int) -> MlfeaturetsnePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsnePath::len(self : MlfeaturetsnePath) -> Int { self.size }

pub fn MlfeaturetsnePath::get(self : MlfeaturetsnePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsnePath::set(self : MlfeaturetsnePath, i : Int, v : Double) -> MlfeaturetsnePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsnePath::sum(self : MlfeaturetsnePath) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsnePath::mean(self : MlfeaturetsnePath) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsnePath::scale(self : MlfeaturetsnePath, f : Double) -> MlfeaturetsnePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsnePath::add(self : MlfeaturetsnePath, other : MlfeaturetsnePath) -> MlfeaturetsnePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsnePath::copy(self : MlfeaturetsnePath) -> MlfeaturetsnePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsnePath::fill(self : MlfeaturetsnePath, v : Double) -> MlfeaturetsnePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsnePath::min(self : MlfeaturetsnePath) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsnePath::max(self : MlfeaturetsnePath) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsnePath::to_string(self : MlfeaturetsnePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_cluster_make(size : Int) -> MlfeaturetsneCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneCluster::len(self : MlfeaturetsneCluster) -> Int { self.size }

pub fn MlfeaturetsneCluster::get(self : MlfeaturetsneCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneCluster::set(self : MlfeaturetsneCluster, i : Int, v : Double) -> MlfeaturetsneCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCluster::sum(self : MlfeaturetsneCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneCluster::mean(self : MlfeaturetsneCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneCluster::scale(self : MlfeaturetsneCluster, f : Double) -> MlfeaturetsneCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCluster::add(self : MlfeaturetsneCluster, other : MlfeaturetsneCluster) -> MlfeaturetsneCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneCluster::copy(self : MlfeaturetsneCluster) -> MlfeaturetsneCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCluster::fill(self : MlfeaturetsneCluster, v : Double) -> MlfeaturetsneCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCluster::min(self : MlfeaturetsneCluster) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneCluster::max(self : MlfeaturetsneCluster) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneCluster::to_string(self : MlfeaturetsneCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_model_make(size : Int) -> MlfeaturetsneModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneModel::len(self : MlfeaturetsneModel) -> Int { self.size }

pub fn MlfeaturetsneModel::get(self : MlfeaturetsneModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneModel::set(self : MlfeaturetsneModel, i : Int, v : Double) -> MlfeaturetsneModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneModel::sum(self : MlfeaturetsneModel) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneModel::mean(self : MlfeaturetsneModel) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneModel::scale(self : MlfeaturetsneModel, f : Double) -> MlfeaturetsneModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneModel::add(self : MlfeaturetsneModel, other : MlfeaturetsneModel) -> MlfeaturetsneModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneModel::copy(self : MlfeaturetsneModel) -> MlfeaturetsneModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneModel::fill(self : MlfeaturetsneModel, v : Double) -> MlfeaturetsneModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneModel::min(self : MlfeaturetsneModel) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneModel::max(self : MlfeaturetsneModel) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneModel::to_string(self : MlfeaturetsneModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_layer_make(size : Int) -> MlfeaturetsneLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneLayer::len(self : MlfeaturetsneLayer) -> Int { self.size }

pub fn MlfeaturetsneLayer::get(self : MlfeaturetsneLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneLayer::set(self : MlfeaturetsneLayer, i : Int, v : Double) -> MlfeaturetsneLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneLayer::sum(self : MlfeaturetsneLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneLayer::mean(self : MlfeaturetsneLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneLayer::scale(self : MlfeaturetsneLayer, f : Double) -> MlfeaturetsneLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneLayer::add(self : MlfeaturetsneLayer, other : MlfeaturetsneLayer) -> MlfeaturetsneLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneLayer::copy(self : MlfeaturetsneLayer) -> MlfeaturetsneLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneLayer::fill(self : MlfeaturetsneLayer, v : Double) -> MlfeaturetsneLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneLayer::min(self : MlfeaturetsneLayer) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneLayer::max(self : MlfeaturetsneLayer) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneLayer::to_string(self : MlfeaturetsneLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_buffer_make(size : Int) -> MlfeaturetsneBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneBuffer::len(self : MlfeaturetsneBuffer) -> Int { self.size }

pub fn MlfeaturetsneBuffer::get(self : MlfeaturetsneBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneBuffer::set(self : MlfeaturetsneBuffer, i : Int, v : Double) -> MlfeaturetsneBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneBuffer::sum(self : MlfeaturetsneBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneBuffer::mean(self : MlfeaturetsneBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneBuffer::scale(self : MlfeaturetsneBuffer, f : Double) -> MlfeaturetsneBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneBuffer::add(self : MlfeaturetsneBuffer, other : MlfeaturetsneBuffer) -> MlfeaturetsneBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneBuffer::copy(self : MlfeaturetsneBuffer) -> MlfeaturetsneBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneBuffer::fill(self : MlfeaturetsneBuffer, v : Double) -> MlfeaturetsneBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneBuffer::min(self : MlfeaturetsneBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneBuffer::max(self : MlfeaturetsneBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneBuffer::to_string(self : MlfeaturetsneBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_cursor_make(size : Int) -> MlfeaturetsneCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneCursor::len(self : MlfeaturetsneCursor) -> Int { self.size }

pub fn MlfeaturetsneCursor::get(self : MlfeaturetsneCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneCursor::set(self : MlfeaturetsneCursor, i : Int, v : Double) -> MlfeaturetsneCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCursor::sum(self : MlfeaturetsneCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneCursor::mean(self : MlfeaturetsneCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneCursor::scale(self : MlfeaturetsneCursor, f : Double) -> MlfeaturetsneCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCursor::add(self : MlfeaturetsneCursor, other : MlfeaturetsneCursor) -> MlfeaturetsneCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneCursor::copy(self : MlfeaturetsneCursor) -> MlfeaturetsneCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCursor::fill(self : MlfeaturetsneCursor, v : Double) -> MlfeaturetsneCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneCursor::min(self : MlfeaturetsneCursor) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneCursor::max(self : MlfeaturetsneCursor) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneCursor::to_string(self : MlfeaturetsneCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_view_make(size : Int) -> MlfeaturetsneView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneView::len(self : MlfeaturetsneView) -> Int { self.size }

pub fn MlfeaturetsneView::get(self : MlfeaturetsneView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneView::set(self : MlfeaturetsneView, i : Int, v : Double) -> MlfeaturetsneView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneView::sum(self : MlfeaturetsneView) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneView::mean(self : MlfeaturetsneView) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneView::scale(self : MlfeaturetsneView, f : Double) -> MlfeaturetsneView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneView::add(self : MlfeaturetsneView, other : MlfeaturetsneView) -> MlfeaturetsneView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneView::copy(self : MlfeaturetsneView) -> MlfeaturetsneView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneView::fill(self : MlfeaturetsneView, v : Double) -> MlfeaturetsneView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneView::min(self : MlfeaturetsneView) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneView::max(self : MlfeaturetsneView) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneView::to_string(self : MlfeaturetsneView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_range_make(size : Int) -> MlfeaturetsneRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneRange::len(self : MlfeaturetsneRange) -> Int { self.size }

pub fn MlfeaturetsneRange::get(self : MlfeaturetsneRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneRange::set(self : MlfeaturetsneRange, i : Int, v : Double) -> MlfeaturetsneRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneRange::sum(self : MlfeaturetsneRange) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneRange::mean(self : MlfeaturetsneRange) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneRange::scale(self : MlfeaturetsneRange, f : Double) -> MlfeaturetsneRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneRange::add(self : MlfeaturetsneRange, other : MlfeaturetsneRange) -> MlfeaturetsneRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneRange::copy(self : MlfeaturetsneRange) -> MlfeaturetsneRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneRange::fill(self : MlfeaturetsneRange, v : Double) -> MlfeaturetsneRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneRange::min(self : MlfeaturetsneRange) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneRange::max(self : MlfeaturetsneRange) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneRange::to_string(self : MlfeaturetsneRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_slice_make(size : Int) -> MlfeaturetsneSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturetsneSlice::len(self : MlfeaturetsneSlice) -> Int { self.size }

pub fn MlfeaturetsneSlice::get(self : MlfeaturetsneSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturetsneSlice::set(self : MlfeaturetsneSlice, i : Int, v : Double) -> MlfeaturetsneSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneSlice::sum(self : MlfeaturetsneSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeaturetsneSlice::mean(self : MlfeaturetsneSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeaturetsneSlice::scale(self : MlfeaturetsneSlice, f : Double) -> MlfeaturetsneSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneSlice::add(self : MlfeaturetsneSlice, other : MlfeaturetsneSlice) -> MlfeaturetsneSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturetsneSlice::copy(self : MlfeaturetsneSlice) -> MlfeaturetsneSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneSlice::fill(self : MlfeaturetsneSlice, v : Double) -> MlfeaturetsneSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturetsneSlice::min(self : MlfeaturetsneSlice) -> Double { @_common.min(self.data) }

pub fn MlfeaturetsneSlice::max(self : MlfeaturetsneSlice) -> Double { @_common.max(self.data) }

pub fn MlfeaturetsneSlice::to_string(self : MlfeaturetsneSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

