///===
/// extcore/opt_meta_nelder

pub(all) struct OptmetanelderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_nelder_make_point(x : Double, y : Double) -> OptmetanelderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_nelder_make_point3(x : Double, y : Double, z : Double) -> OptmetanelderPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetanelderPoint::x(self : OptmetanelderPoint) -> Double { self.x }

pub fn OptmetanelderPoint::y(self : OptmetanelderPoint) -> Double { self.y }

pub fn OptmetanelderPoint::z(self : OptmetanelderPoint) -> Double { self.z }

pub fn OptmetanelderPoint::label(self : OptmetanelderPoint) -> Int { self.label }

pub fn OptmetanelderPoint::dist(self : OptmetanelderPoint, other : OptmetanelderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetanelderPoint::add(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetanelderPoint::sub(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetanelderPoint::scale(self : OptmetanelderPoint, s : Double) -> OptmetanelderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetanelderPoint::dot(self : OptmetanelderPoint, other : OptmetanelderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetanelderPoint::cross(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetanelderPoint::norm(self : OptmetanelderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetanelderPoint::normalize(self : OptmetanelderPoint) -> OptmetanelderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetanelderPoint::negate(self : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetanelderPoint::mid(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetanelderPoint::lerp(self : OptmetanelderPoint, other : OptmetanelderPoint, t : Double) -> OptmetanelderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetanelderPoint::to_string(self : OptmetanelderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetanelderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_nelder_make_series(vals : Array[Double], name : String) -> OptmetanelderSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetanelderSeries::len(self : OptmetanelderSeries) -> Int { self.vals.length() }

pub fn OptmetanelderSeries::sum(self : OptmetanelderSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetanelderSeries::mean(self : OptmetanelderSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetanelderSeries::min(self : OptmetanelderSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetanelderSeries::max(self : OptmetanelderSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetanelderSeries::range(self : OptmetanelderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetanelderSeries::variance(self : OptmetanelderSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetanelderSeries::std(self : OptmetanelderSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetanelderSeries::median(self : OptmetanelderSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetanelderSeries::scale(self : OptmetanelderSeries, f : Double) -> OptmetanelderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetanelderSeries::add(self : OptmetanelderSeries, other : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetanelderSeries::sub(self : OptmetanelderSeries, other : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetanelderSeries::normalize(self : OptmetanelderSeries) -> OptmetanelderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetanelderSeries::cumsum(self : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetanelderSeries::to_string(self : OptmetanelderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetanelderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_nelder_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetanelderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_nelder_matrix_identity(n : Int) -> OptmetanelderMatrix {
  let m = opt_meta_nelder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetanelderMatrix::get(self : OptmetanelderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetanelderMatrix::transpose(self : OptmetanelderMatrix) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetanelderMatrix::add(self : OptmetanelderMatrix, other : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_nelder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetanelderMatrix::scale(self : OptmetanelderMatrix, s : Double) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetanelderMatrix::multiply(self : OptmetanelderMatrix, other : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if self.cols != other.rows { return opt_meta_nelder_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_nelder_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetanelderMatrix::trace(self : OptmetanelderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetanelderMatrix::det(self : OptmetanelderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetanelderMatrix::norm(self : OptmetanelderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetanelderMatrix::to_string(self : OptmetanelderMatrix) -> String {
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

pub(all) struct OptmetanelderVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_nelder_make_vector(comps : Array[Double]) -> OptmetanelderVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_nelder_vector_zero(dim : Int) -> OptmetanelderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetanelderVector::add(self : OptmetanelderVector, other : OptmetanelderVector) -> OptmetanelderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetanelderVector::sub(self : OptmetanelderVector, other : OptmetanelderVector) -> OptmetanelderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetanelderVector::scale(self : OptmetanelderVector, s : Double) -> OptmetanelderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetanelderVector::dot(self : OptmetanelderVector, other : OptmetanelderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetanelderVector::norm(self : OptmetanelderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetanelderVector::normalize(self : OptmetanelderVector) -> OptmetanelderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetanelderVector::dist(self : OptmetanelderVector, other : OptmetanelderVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetanelderVector::to_string(self : OptmetanelderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_nelder_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_nelder_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_nelder_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_nelder_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_nelder_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_nelder_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_nelder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_nelder_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_nelder_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_nelder_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_nelder_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_nelder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_nelder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_nelder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_nelder_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_nelder_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_nelder_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_nelder_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_nelder_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_nelder_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_nelder_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_nelder_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_nelder_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_nelder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_nelder_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_nelder_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_nelder_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_nelder_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_nelder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetanelderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_frame_make(size : Int) -> OptmetanelderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_frame_len(s : OptmetanelderFrame) -> Int { s.size }

pub fn opt_meta_nelder_frame_get(s : OptmetanelderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_frame_set(s : OptmetanelderFrame, i : Int, v : Double) -> OptmetanelderFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_frame_sum(s : OptmetanelderFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_frame_mean(s : OptmetanelderFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_frame_scale(s : OptmetanelderFrame, f : Double) -> OptmetanelderFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_frame_add(a : OptmetanelderFrame, b : OptmetanelderFrame) -> OptmetanelderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_frame_copy(s : OptmetanelderFrame) -> OptmetanelderFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_frame_fill(s : OptmetanelderFrame, v : Double) -> OptmetanelderFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_frame_min(s : OptmetanelderFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_frame_max(s : OptmetanelderFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_frame_to_string(s : OptmetanelderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_table_make(size : Int) -> OptmetanelderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_table_len(s : OptmetanelderTable) -> Int { s.size }

pub fn opt_meta_nelder_table_get(s : OptmetanelderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_table_set(s : OptmetanelderTable, i : Int, v : Double) -> OptmetanelderTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_table_sum(s : OptmetanelderTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_table_mean(s : OptmetanelderTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_table_scale(s : OptmetanelderTable, f : Double) -> OptmetanelderTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_table_add(a : OptmetanelderTable, b : OptmetanelderTable) -> OptmetanelderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_table_copy(s : OptmetanelderTable) -> OptmetanelderTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_table_fill(s : OptmetanelderTable, v : Double) -> OptmetanelderTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_table_min(s : OptmetanelderTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_table_max(s : OptmetanelderTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_table_to_string(s : OptmetanelderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_graphn_make(size : Int) -> OptmetanelderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_graphn_len(s : OptmetanelderGraphN) -> Int { s.size }

pub fn opt_meta_nelder_graphn_get(s : OptmetanelderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_graphn_set(s : OptmetanelderGraphN, i : Int, v : Double) -> OptmetanelderGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_graphn_sum(s : OptmetanelderGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_graphn_mean(s : OptmetanelderGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_graphn_scale(s : OptmetanelderGraphN, f : Double) -> OptmetanelderGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_graphn_add(a : OptmetanelderGraphN, b : OptmetanelderGraphN) -> OptmetanelderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_graphn_copy(s : OptmetanelderGraphN) -> OptmetanelderGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_graphn_fill(s : OptmetanelderGraphN, v : Double) -> OptmetanelderGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_graphn_min(s : OptmetanelderGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_graphn_max(s : OptmetanelderGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_graphn_to_string(s : OptmetanelderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_node_make(size : Int) -> OptmetanelderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_node_len(s : OptmetanelderNode) -> Int { s.size }

pub fn opt_meta_nelder_node_get(s : OptmetanelderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_node_set(s : OptmetanelderNode, i : Int, v : Double) -> OptmetanelderNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_node_sum(s : OptmetanelderNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_node_mean(s : OptmetanelderNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_node_scale(s : OptmetanelderNode, f : Double) -> OptmetanelderNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_node_add(a : OptmetanelderNode, b : OptmetanelderNode) -> OptmetanelderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_node_copy(s : OptmetanelderNode) -> OptmetanelderNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_node_fill(s : OptmetanelderNode, v : Double) -> OptmetanelderNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_node_min(s : OptmetanelderNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_node_max(s : OptmetanelderNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_node_to_string(s : OptmetanelderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_edge_make(size : Int) -> OptmetanelderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_edge_len(s : OptmetanelderEdge) -> Int { s.size }

pub fn opt_meta_nelder_edge_get(s : OptmetanelderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_edge_set(s : OptmetanelderEdge, i : Int, v : Double) -> OptmetanelderEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_edge_sum(s : OptmetanelderEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_edge_mean(s : OptmetanelderEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_edge_scale(s : OptmetanelderEdge, f : Double) -> OptmetanelderEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_edge_add(a : OptmetanelderEdge, b : OptmetanelderEdge) -> OptmetanelderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_edge_copy(s : OptmetanelderEdge) -> OptmetanelderEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_edge_fill(s : OptmetanelderEdge, v : Double) -> OptmetanelderEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_edge_min(s : OptmetanelderEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_edge_max(s : OptmetanelderEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_edge_to_string(s : OptmetanelderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_path_make(size : Int) -> OptmetanelderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_path_len(s : OptmetanelderPath) -> Int { s.size }

pub fn opt_meta_nelder_path_get(s : OptmetanelderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_path_set(s : OptmetanelderPath, i : Int, v : Double) -> OptmetanelderPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_path_sum(s : OptmetanelderPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_path_mean(s : OptmetanelderPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_path_scale(s : OptmetanelderPath, f : Double) -> OptmetanelderPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_path_add(a : OptmetanelderPath, b : OptmetanelderPath) -> OptmetanelderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_path_copy(s : OptmetanelderPath) -> OptmetanelderPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_path_fill(s : OptmetanelderPath, v : Double) -> OptmetanelderPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_path_min(s : OptmetanelderPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_path_max(s : OptmetanelderPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_path_to_string(s : OptmetanelderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cluster_make(size : Int) -> OptmetanelderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_cluster_len(s : OptmetanelderCluster) -> Int { s.size }

pub fn opt_meta_nelder_cluster_get(s : OptmetanelderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_cluster_set(s : OptmetanelderCluster, i : Int, v : Double) -> OptmetanelderCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cluster_sum(s : OptmetanelderCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_cluster_mean(s : OptmetanelderCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_cluster_scale(s : OptmetanelderCluster, f : Double) -> OptmetanelderCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cluster_add(a : OptmetanelderCluster, b : OptmetanelderCluster) -> OptmetanelderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_cluster_copy(s : OptmetanelderCluster) -> OptmetanelderCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cluster_fill(s : OptmetanelderCluster, v : Double) -> OptmetanelderCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cluster_min(s : OptmetanelderCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_cluster_max(s : OptmetanelderCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_cluster_to_string(s : OptmetanelderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_model_make(size : Int) -> OptmetanelderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_model_len(s : OptmetanelderModel) -> Int { s.size }

pub fn opt_meta_nelder_model_get(s : OptmetanelderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_model_set(s : OptmetanelderModel, i : Int, v : Double) -> OptmetanelderModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_model_sum(s : OptmetanelderModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_model_mean(s : OptmetanelderModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_model_scale(s : OptmetanelderModel, f : Double) -> OptmetanelderModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_model_add(a : OptmetanelderModel, b : OptmetanelderModel) -> OptmetanelderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_model_copy(s : OptmetanelderModel) -> OptmetanelderModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_model_fill(s : OptmetanelderModel, v : Double) -> OptmetanelderModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_model_min(s : OptmetanelderModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_model_max(s : OptmetanelderModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_model_to_string(s : OptmetanelderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_layer_make(size : Int) -> OptmetanelderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_layer_len(s : OptmetanelderLayer) -> Int { s.size }

pub fn opt_meta_nelder_layer_get(s : OptmetanelderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_layer_set(s : OptmetanelderLayer, i : Int, v : Double) -> OptmetanelderLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_layer_sum(s : OptmetanelderLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_layer_mean(s : OptmetanelderLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_layer_scale(s : OptmetanelderLayer, f : Double) -> OptmetanelderLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_layer_add(a : OptmetanelderLayer, b : OptmetanelderLayer) -> OptmetanelderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_layer_copy(s : OptmetanelderLayer) -> OptmetanelderLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_layer_fill(s : OptmetanelderLayer, v : Double) -> OptmetanelderLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_layer_min(s : OptmetanelderLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_layer_max(s : OptmetanelderLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_layer_to_string(s : OptmetanelderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_buffer_make(size : Int) -> OptmetanelderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_buffer_len(s : OptmetanelderBuffer) -> Int { s.size }

pub fn opt_meta_nelder_buffer_get(s : OptmetanelderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_buffer_set(s : OptmetanelderBuffer, i : Int, v : Double) -> OptmetanelderBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_buffer_sum(s : OptmetanelderBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_buffer_mean(s : OptmetanelderBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_buffer_scale(s : OptmetanelderBuffer, f : Double) -> OptmetanelderBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_buffer_add(a : OptmetanelderBuffer, b : OptmetanelderBuffer) -> OptmetanelderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_buffer_copy(s : OptmetanelderBuffer) -> OptmetanelderBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_buffer_fill(s : OptmetanelderBuffer, v : Double) -> OptmetanelderBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_buffer_min(s : OptmetanelderBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_buffer_max(s : OptmetanelderBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_buffer_to_string(s : OptmetanelderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cursor_make(size : Int) -> OptmetanelderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_cursor_len(s : OptmetanelderCursor) -> Int { s.size }

pub fn opt_meta_nelder_cursor_get(s : OptmetanelderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_cursor_set(s : OptmetanelderCursor, i : Int, v : Double) -> OptmetanelderCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cursor_sum(s : OptmetanelderCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_cursor_mean(s : OptmetanelderCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_cursor_scale(s : OptmetanelderCursor, f : Double) -> OptmetanelderCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cursor_add(a : OptmetanelderCursor, b : OptmetanelderCursor) -> OptmetanelderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_cursor_copy(s : OptmetanelderCursor) -> OptmetanelderCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cursor_fill(s : OptmetanelderCursor, v : Double) -> OptmetanelderCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_cursor_min(s : OptmetanelderCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_cursor_max(s : OptmetanelderCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_cursor_to_string(s : OptmetanelderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_view_make(size : Int) -> OptmetanelderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_view_len(s : OptmetanelderView) -> Int { s.size }

pub fn opt_meta_nelder_view_get(s : OptmetanelderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_view_set(s : OptmetanelderView, i : Int, v : Double) -> OptmetanelderView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_view_sum(s : OptmetanelderView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_view_mean(s : OptmetanelderView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_view_scale(s : OptmetanelderView, f : Double) -> OptmetanelderView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_view_add(a : OptmetanelderView, b : OptmetanelderView) -> OptmetanelderView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_view_copy(s : OptmetanelderView) -> OptmetanelderView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_view_fill(s : OptmetanelderView, v : Double) -> OptmetanelderView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_view_min(s : OptmetanelderView) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_view_max(s : OptmetanelderView) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_view_to_string(s : OptmetanelderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_range_make(size : Int) -> OptmetanelderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_range_len(s : OptmetanelderRange) -> Int { s.size }

pub fn opt_meta_nelder_range_get(s : OptmetanelderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_range_set(s : OptmetanelderRange, i : Int, v : Double) -> OptmetanelderRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_range_sum(s : OptmetanelderRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_range_mean(s : OptmetanelderRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_range_scale(s : OptmetanelderRange, f : Double) -> OptmetanelderRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_range_add(a : OptmetanelderRange, b : OptmetanelderRange) -> OptmetanelderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_range_copy(s : OptmetanelderRange) -> OptmetanelderRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_range_fill(s : OptmetanelderRange, v : Double) -> OptmetanelderRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_range_min(s : OptmetanelderRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_range_max(s : OptmetanelderRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_range_to_string(s : OptmetanelderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_slice_make(size : Int) -> OptmetanelderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_slice_len(s : OptmetanelderSlice) -> Int { s.size }

pub fn opt_meta_nelder_slice_get(s : OptmetanelderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_slice_set(s : OptmetanelderSlice, i : Int, v : Double) -> OptmetanelderSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_slice_sum(s : OptmetanelderSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_nelder_slice_mean(s : OptmetanelderSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_nelder_slice_scale(s : OptmetanelderSlice, f : Double) -> OptmetanelderSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_slice_add(a : OptmetanelderSlice, b : OptmetanelderSlice) -> OptmetanelderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_nelder_slice_copy(s : OptmetanelderSlice) -> OptmetanelderSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_slice_fill(s : OptmetanelderSlice, v : Double) -> OptmetanelderSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_nelder_slice_min(s : OptmetanelderSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_nelder_slice_max(s : OptmetanelderSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_nelder_slice_to_string(s : OptmetanelderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

