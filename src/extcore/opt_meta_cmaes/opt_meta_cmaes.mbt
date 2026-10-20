///===
/// extcore/opt_meta_cmaes

pub(all) struct OptmetacmaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_cmaes_make_point(x : Double, y : Double) -> OptmetacmaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_cmaes_make_point3(x : Double, y : Double, z : Double) -> OptmetacmaesPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetacmaesPoint::x(self : OptmetacmaesPoint) -> Double { self.x }

pub fn OptmetacmaesPoint::y(self : OptmetacmaesPoint) -> Double { self.y }

pub fn OptmetacmaesPoint::z(self : OptmetacmaesPoint) -> Double { self.z }

pub fn OptmetacmaesPoint::label(self : OptmetacmaesPoint) -> Int { self.label }

pub fn OptmetacmaesPoint::dist(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetacmaesPoint::add(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetacmaesPoint::sub(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetacmaesPoint::scale(self : OptmetacmaesPoint, s : Double) -> OptmetacmaesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetacmaesPoint::dot(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetacmaesPoint::cross(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetacmaesPoint::norm(self : OptmetacmaesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetacmaesPoint::normalize(self : OptmetacmaesPoint) -> OptmetacmaesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetacmaesPoint::negate(self : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetacmaesPoint::mid(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetacmaesPoint::lerp(self : OptmetacmaesPoint, other : OptmetacmaesPoint, t : Double) -> OptmetacmaesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetacmaesPoint::to_string(self : OptmetacmaesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetacmaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_cmaes_make_series(vals : Array[Double], name : String) -> OptmetacmaesSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetacmaesSeries::len(self : OptmetacmaesSeries) -> Int { self.vals.length() }

pub fn OptmetacmaesSeries::sum(self : OptmetacmaesSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetacmaesSeries::mean(self : OptmetacmaesSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetacmaesSeries::min(self : OptmetacmaesSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetacmaesSeries::max(self : OptmetacmaesSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetacmaesSeries::range(self : OptmetacmaesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetacmaesSeries::variance(self : OptmetacmaesSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetacmaesSeries::std(self : OptmetacmaesSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetacmaesSeries::median(self : OptmetacmaesSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetacmaesSeries::scale(self : OptmetacmaesSeries, f : Double) -> OptmetacmaesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::add(self : OptmetacmaesSeries, other : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::sub(self : OptmetacmaesSeries, other : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::normalize(self : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetacmaesSeries::cumsum(self : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetacmaesSeries::to_string(self : OptmetacmaesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetacmaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_cmaes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetacmaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_cmaes_matrix_identity(n : Int) -> OptmetacmaesMatrix {
  let m = opt_meta_cmaes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetacmaesMatrix::get(self : OptmetacmaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetacmaesMatrix::transpose(self : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetacmaesMatrix::add(self : OptmetacmaesMatrix, other : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_cmaes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetacmaesMatrix::scale(self : OptmetacmaesMatrix, s : Double) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetacmaesMatrix::multiply(self : OptmetacmaesMatrix, other : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if self.cols != other.rows { return opt_meta_cmaes_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_cmaes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetacmaesMatrix::trace(self : OptmetacmaesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetacmaesMatrix::det(self : OptmetacmaesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetacmaesMatrix::norm(self : OptmetacmaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetacmaesMatrix::to_string(self : OptmetacmaesMatrix) -> String {
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

pub(all) struct OptmetacmaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_cmaes_make_vector(comps : Array[Double]) -> OptmetacmaesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_cmaes_vector_zero(dim : Int) -> OptmetacmaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetacmaesVector::add(self : OptmetacmaesVector, other : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetacmaesVector::sub(self : OptmetacmaesVector, other : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetacmaesVector::scale(self : OptmetacmaesVector, s : Double) -> OptmetacmaesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetacmaesVector::dot(self : OptmetacmaesVector, other : OptmetacmaesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetacmaesVector::norm(self : OptmetacmaesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetacmaesVector::normalize(self : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetacmaesVector::dist(self : OptmetacmaesVector, other : OptmetacmaesVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetacmaesVector::to_string(self : OptmetacmaesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_cmaes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_cmaes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_cmaes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_cmaes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_cmaes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_cmaes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_cmaes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_cmaes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_cmaes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_cmaes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_cmaes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_cmaes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_cmaes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_cmaes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_cmaes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_cmaes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_cmaes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_cmaes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_cmaes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_cmaes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_cmaes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_cmaes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_cmaes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_cmaes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_cmaes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_cmaes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_cmaes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_cmaes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_cmaes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetacmaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_frame_make(size : Int) -> OptmetacmaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_frame_len(s : OptmetacmaesFrame) -> Int { s.size }

pub fn opt_meta_cmaes_frame_get(s : OptmetacmaesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_frame_set(s : OptmetacmaesFrame, i : Int, v : Double) -> OptmetacmaesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_sum(s : OptmetacmaesFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_frame_mean(s : OptmetacmaesFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_frame_scale(s : OptmetacmaesFrame, f : Double) -> OptmetacmaesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_add(a : OptmetacmaesFrame, b : OptmetacmaesFrame) -> OptmetacmaesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_frame_copy(s : OptmetacmaesFrame) -> OptmetacmaesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_fill(s : OptmetacmaesFrame, v : Double) -> OptmetacmaesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_min(s : OptmetacmaesFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_frame_max(s : OptmetacmaesFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_frame_to_string(s : OptmetacmaesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_table_make(size : Int) -> OptmetacmaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_table_len(s : OptmetacmaesTable) -> Int { s.size }

pub fn opt_meta_cmaes_table_get(s : OptmetacmaesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_table_set(s : OptmetacmaesTable, i : Int, v : Double) -> OptmetacmaesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_sum(s : OptmetacmaesTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_table_mean(s : OptmetacmaesTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_table_scale(s : OptmetacmaesTable, f : Double) -> OptmetacmaesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_add(a : OptmetacmaesTable, b : OptmetacmaesTable) -> OptmetacmaesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_table_copy(s : OptmetacmaesTable) -> OptmetacmaesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_fill(s : OptmetacmaesTable, v : Double) -> OptmetacmaesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_min(s : OptmetacmaesTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_table_max(s : OptmetacmaesTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_table_to_string(s : OptmetacmaesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_graphn_make(size : Int) -> OptmetacmaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_graphn_len(s : OptmetacmaesGraphN) -> Int { s.size }

pub fn opt_meta_cmaes_graphn_get(s : OptmetacmaesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_graphn_set(s : OptmetacmaesGraphN, i : Int, v : Double) -> OptmetacmaesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_sum(s : OptmetacmaesGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_graphn_mean(s : OptmetacmaesGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_graphn_scale(s : OptmetacmaesGraphN, f : Double) -> OptmetacmaesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_add(a : OptmetacmaesGraphN, b : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_graphn_copy(s : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_fill(s : OptmetacmaesGraphN, v : Double) -> OptmetacmaesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_min(s : OptmetacmaesGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_graphn_max(s : OptmetacmaesGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_graphn_to_string(s : OptmetacmaesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_node_make(size : Int) -> OptmetacmaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_node_len(s : OptmetacmaesNode) -> Int { s.size }

pub fn opt_meta_cmaes_node_get(s : OptmetacmaesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_node_set(s : OptmetacmaesNode, i : Int, v : Double) -> OptmetacmaesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_sum(s : OptmetacmaesNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_node_mean(s : OptmetacmaesNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_node_scale(s : OptmetacmaesNode, f : Double) -> OptmetacmaesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_add(a : OptmetacmaesNode, b : OptmetacmaesNode) -> OptmetacmaesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_node_copy(s : OptmetacmaesNode) -> OptmetacmaesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_fill(s : OptmetacmaesNode, v : Double) -> OptmetacmaesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_min(s : OptmetacmaesNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_node_max(s : OptmetacmaesNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_node_to_string(s : OptmetacmaesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_edge_make(size : Int) -> OptmetacmaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_edge_len(s : OptmetacmaesEdge) -> Int { s.size }

pub fn opt_meta_cmaes_edge_get(s : OptmetacmaesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_edge_set(s : OptmetacmaesEdge, i : Int, v : Double) -> OptmetacmaesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_sum(s : OptmetacmaesEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_edge_mean(s : OptmetacmaesEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_edge_scale(s : OptmetacmaesEdge, f : Double) -> OptmetacmaesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_add(a : OptmetacmaesEdge, b : OptmetacmaesEdge) -> OptmetacmaesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_edge_copy(s : OptmetacmaesEdge) -> OptmetacmaesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_fill(s : OptmetacmaesEdge, v : Double) -> OptmetacmaesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_min(s : OptmetacmaesEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_edge_max(s : OptmetacmaesEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_edge_to_string(s : OptmetacmaesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_path_make(size : Int) -> OptmetacmaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_path_len(s : OptmetacmaesPath) -> Int { s.size }

pub fn opt_meta_cmaes_path_get(s : OptmetacmaesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_path_set(s : OptmetacmaesPath, i : Int, v : Double) -> OptmetacmaesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_sum(s : OptmetacmaesPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_path_mean(s : OptmetacmaesPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_path_scale(s : OptmetacmaesPath, f : Double) -> OptmetacmaesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_add(a : OptmetacmaesPath, b : OptmetacmaesPath) -> OptmetacmaesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_path_copy(s : OptmetacmaesPath) -> OptmetacmaesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_fill(s : OptmetacmaesPath, v : Double) -> OptmetacmaesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_min(s : OptmetacmaesPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_path_max(s : OptmetacmaesPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_path_to_string(s : OptmetacmaesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cluster_make(size : Int) -> OptmetacmaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cluster_len(s : OptmetacmaesCluster) -> Int { s.size }

pub fn opt_meta_cmaes_cluster_get(s : OptmetacmaesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cluster_set(s : OptmetacmaesCluster, i : Int, v : Double) -> OptmetacmaesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_sum(s : OptmetacmaesCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_cluster_mean(s : OptmetacmaesCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_cluster_scale(s : OptmetacmaesCluster, f : Double) -> OptmetacmaesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_add(a : OptmetacmaesCluster, b : OptmetacmaesCluster) -> OptmetacmaesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_cluster_copy(s : OptmetacmaesCluster) -> OptmetacmaesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_fill(s : OptmetacmaesCluster, v : Double) -> OptmetacmaesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_min(s : OptmetacmaesCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_cluster_max(s : OptmetacmaesCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_cluster_to_string(s : OptmetacmaesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_model_make(size : Int) -> OptmetacmaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_model_len(s : OptmetacmaesModel) -> Int { s.size }

pub fn opt_meta_cmaes_model_get(s : OptmetacmaesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_model_set(s : OptmetacmaesModel, i : Int, v : Double) -> OptmetacmaesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_sum(s : OptmetacmaesModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_model_mean(s : OptmetacmaesModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_model_scale(s : OptmetacmaesModel, f : Double) -> OptmetacmaesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_add(a : OptmetacmaesModel, b : OptmetacmaesModel) -> OptmetacmaesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_model_copy(s : OptmetacmaesModel) -> OptmetacmaesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_fill(s : OptmetacmaesModel, v : Double) -> OptmetacmaesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_min(s : OptmetacmaesModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_model_max(s : OptmetacmaesModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_model_to_string(s : OptmetacmaesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_layer_make(size : Int) -> OptmetacmaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_layer_len(s : OptmetacmaesLayer) -> Int { s.size }

pub fn opt_meta_cmaes_layer_get(s : OptmetacmaesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_layer_set(s : OptmetacmaesLayer, i : Int, v : Double) -> OptmetacmaesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_sum(s : OptmetacmaesLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_layer_mean(s : OptmetacmaesLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_layer_scale(s : OptmetacmaesLayer, f : Double) -> OptmetacmaesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_add(a : OptmetacmaesLayer, b : OptmetacmaesLayer) -> OptmetacmaesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_layer_copy(s : OptmetacmaesLayer) -> OptmetacmaesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_fill(s : OptmetacmaesLayer, v : Double) -> OptmetacmaesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_min(s : OptmetacmaesLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_layer_max(s : OptmetacmaesLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_layer_to_string(s : OptmetacmaesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_buffer_make(size : Int) -> OptmetacmaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_buffer_len(s : OptmetacmaesBuffer) -> Int { s.size }

pub fn opt_meta_cmaes_buffer_get(s : OptmetacmaesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_buffer_set(s : OptmetacmaesBuffer, i : Int, v : Double) -> OptmetacmaesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_sum(s : OptmetacmaesBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_buffer_mean(s : OptmetacmaesBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_buffer_scale(s : OptmetacmaesBuffer, f : Double) -> OptmetacmaesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_add(a : OptmetacmaesBuffer, b : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_buffer_copy(s : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_fill(s : OptmetacmaesBuffer, v : Double) -> OptmetacmaesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_min(s : OptmetacmaesBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_buffer_max(s : OptmetacmaesBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_buffer_to_string(s : OptmetacmaesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cursor_make(size : Int) -> OptmetacmaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cursor_len(s : OptmetacmaesCursor) -> Int { s.size }

pub fn opt_meta_cmaes_cursor_get(s : OptmetacmaesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cursor_set(s : OptmetacmaesCursor, i : Int, v : Double) -> OptmetacmaesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_sum(s : OptmetacmaesCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_cursor_mean(s : OptmetacmaesCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_cursor_scale(s : OptmetacmaesCursor, f : Double) -> OptmetacmaesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_add(a : OptmetacmaesCursor, b : OptmetacmaesCursor) -> OptmetacmaesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_cursor_copy(s : OptmetacmaesCursor) -> OptmetacmaesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_fill(s : OptmetacmaesCursor, v : Double) -> OptmetacmaesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_min(s : OptmetacmaesCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_cursor_max(s : OptmetacmaesCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_cursor_to_string(s : OptmetacmaesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_view_make(size : Int) -> OptmetacmaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_view_len(s : OptmetacmaesView) -> Int { s.size }

pub fn opt_meta_cmaes_view_get(s : OptmetacmaesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_view_set(s : OptmetacmaesView, i : Int, v : Double) -> OptmetacmaesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_sum(s : OptmetacmaesView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_view_mean(s : OptmetacmaesView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_view_scale(s : OptmetacmaesView, f : Double) -> OptmetacmaesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_add(a : OptmetacmaesView, b : OptmetacmaesView) -> OptmetacmaesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_view_copy(s : OptmetacmaesView) -> OptmetacmaesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_fill(s : OptmetacmaesView, v : Double) -> OptmetacmaesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_min(s : OptmetacmaesView) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_view_max(s : OptmetacmaesView) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_view_to_string(s : OptmetacmaesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_range_make(size : Int) -> OptmetacmaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_range_len(s : OptmetacmaesRange) -> Int { s.size }

pub fn opt_meta_cmaes_range_get(s : OptmetacmaesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_range_set(s : OptmetacmaesRange, i : Int, v : Double) -> OptmetacmaesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_sum(s : OptmetacmaesRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_range_mean(s : OptmetacmaesRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_range_scale(s : OptmetacmaesRange, f : Double) -> OptmetacmaesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_add(a : OptmetacmaesRange, b : OptmetacmaesRange) -> OptmetacmaesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_range_copy(s : OptmetacmaesRange) -> OptmetacmaesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_fill(s : OptmetacmaesRange, v : Double) -> OptmetacmaesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_min(s : OptmetacmaesRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_range_max(s : OptmetacmaesRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_range_to_string(s : OptmetacmaesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_slice_make(size : Int) -> OptmetacmaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_slice_len(s : OptmetacmaesSlice) -> Int { s.size }

pub fn opt_meta_cmaes_slice_get(s : OptmetacmaesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_slice_set(s : OptmetacmaesSlice, i : Int, v : Double) -> OptmetacmaesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_sum(s : OptmetacmaesSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_slice_mean(s : OptmetacmaesSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_slice_scale(s : OptmetacmaesSlice, f : Double) -> OptmetacmaesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_add(a : OptmetacmaesSlice, b : OptmetacmaesSlice) -> OptmetacmaesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_slice_copy(s : OptmetacmaesSlice) -> OptmetacmaesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_fill(s : OptmetacmaesSlice, v : Double) -> OptmetacmaesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_min(s : OptmetacmaesSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_slice_max(s : OptmetacmaesSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_slice_to_string(s : OptmetacmaesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

