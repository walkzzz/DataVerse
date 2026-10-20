///===
/// extcore/db_store_graph

pub(all) struct DbstoregraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_graph_make_point(x : Double, y : Double) -> DbstoregraphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_graph_make_point3(x : Double, y : Double, z : Double) -> DbstoregraphPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoregraphPoint::x(self : DbstoregraphPoint) -> Double { self.x }

pub fn DbstoregraphPoint::y(self : DbstoregraphPoint) -> Double { self.y }

pub fn DbstoregraphPoint::z(self : DbstoregraphPoint) -> Double { self.z }

pub fn DbstoregraphPoint::label(self : DbstoregraphPoint) -> Int { self.label }

pub fn DbstoregraphPoint::dist(self : DbstoregraphPoint, other : DbstoregraphPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoregraphPoint::add(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoregraphPoint::sub(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoregraphPoint::scale(self : DbstoregraphPoint, s : Double) -> DbstoregraphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoregraphPoint::dot(self : DbstoregraphPoint, other : DbstoregraphPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoregraphPoint::cross(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoregraphPoint::norm(self : DbstoregraphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoregraphPoint::normalize(self : DbstoregraphPoint) -> DbstoregraphPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoregraphPoint::negate(self : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoregraphPoint::mid(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoregraphPoint::lerp(self : DbstoregraphPoint, other : DbstoregraphPoint, t : Double) -> DbstoregraphPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoregraphPoint::to_string(self : DbstoregraphPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoregraphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_graph_make_series(vals : Array[Double], name : String) -> DbstoregraphSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoregraphSeries::len(self : DbstoregraphSeries) -> Int { self.vals.length() }

pub fn DbstoregraphSeries::sum(self : DbstoregraphSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoregraphSeries::mean(self : DbstoregraphSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoregraphSeries::min(self : DbstoregraphSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoregraphSeries::max(self : DbstoregraphSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoregraphSeries::range(self : DbstoregraphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoregraphSeries::variance(self : DbstoregraphSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoregraphSeries::std(self : DbstoregraphSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoregraphSeries::median(self : DbstoregraphSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoregraphSeries::scale(self : DbstoregraphSeries, f : Double) -> DbstoregraphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoregraphSeries::add(self : DbstoregraphSeries, other : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoregraphSeries::sub(self : DbstoregraphSeries, other : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoregraphSeries::normalize(self : DbstoregraphSeries) -> DbstoregraphSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoregraphSeries::cumsum(self : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoregraphSeries::to_string(self : DbstoregraphSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoregraphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_graph_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoregraphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_graph_matrix_identity(n : Int) -> DbstoregraphMatrix {
  let m = db_store_graph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoregraphMatrix::get(self : DbstoregraphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoregraphMatrix::transpose(self : DbstoregraphMatrix) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoregraphMatrix::add(self : DbstoregraphMatrix, other : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoregraphMatrix::scale(self : DbstoregraphMatrix, s : Double) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoregraphMatrix::multiply(self : DbstoregraphMatrix, other : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if self.cols != other.rows { return db_store_graph_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_graph_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoregraphMatrix::trace(self : DbstoregraphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoregraphMatrix::det(self : DbstoregraphMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoregraphMatrix::norm(self : DbstoregraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoregraphMatrix::to_string(self : DbstoregraphMatrix) -> String {
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

pub(all) struct DbstoregraphVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_graph_make_vector(comps : Array[Double]) -> DbstoregraphVector {
  { comps, dim: comps.length() }
}

pub fn db_store_graph_vector_zero(dim : Int) -> DbstoregraphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoregraphVector::add(self : DbstoregraphVector, other : DbstoregraphVector) -> DbstoregraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoregraphVector::sub(self : DbstoregraphVector, other : DbstoregraphVector) -> DbstoregraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoregraphVector::scale(self : DbstoregraphVector, s : Double) -> DbstoregraphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoregraphVector::dot(self : DbstoregraphVector, other : DbstoregraphVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoregraphVector::norm(self : DbstoregraphVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoregraphVector::normalize(self : DbstoregraphVector) -> DbstoregraphVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoregraphVector::dist(self : DbstoregraphVector, other : DbstoregraphVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoregraphVector::to_string(self : DbstoregraphVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_graph_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_graph_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_graph_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_graph_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_graph_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_graph_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_graph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_graph_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_graph_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_graph_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_graph_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_graph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_graph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_graph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_graph_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_graph_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_graph_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_graph_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_graph_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_graph_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_graph_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_graph_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_graph_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_graph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_graph_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_graph_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_graph_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_graph_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_graph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoregraphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_frame_make(size : Int) -> DbstoregraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_frame_len(s : DbstoregraphFrame) -> Int { s.size }

pub fn db_store_graph_frame_get(s : DbstoregraphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_frame_set(s : DbstoregraphFrame, i : Int, v : Double) -> DbstoregraphFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_frame_sum(s : DbstoregraphFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_frame_mean(s : DbstoregraphFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_frame_scale(s : DbstoregraphFrame, f : Double) -> DbstoregraphFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_frame_add(a : DbstoregraphFrame, b : DbstoregraphFrame) -> DbstoregraphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_frame_copy(s : DbstoregraphFrame) -> DbstoregraphFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_frame_fill(s : DbstoregraphFrame, v : Double) -> DbstoregraphFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_frame_min(s : DbstoregraphFrame) -> Double { @_common.min(s.data) }

pub fn db_store_graph_frame_max(s : DbstoregraphFrame) -> Double { @_common.max(s.data) }

pub fn db_store_graph_frame_to_string(s : DbstoregraphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_table_make(size : Int) -> DbstoregraphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_table_len(s : DbstoregraphTable) -> Int { s.size }

pub fn db_store_graph_table_get(s : DbstoregraphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_table_set(s : DbstoregraphTable, i : Int, v : Double) -> DbstoregraphTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_table_sum(s : DbstoregraphTable) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_table_mean(s : DbstoregraphTable) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_table_scale(s : DbstoregraphTable, f : Double) -> DbstoregraphTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_table_add(a : DbstoregraphTable, b : DbstoregraphTable) -> DbstoregraphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_table_copy(s : DbstoregraphTable) -> DbstoregraphTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_table_fill(s : DbstoregraphTable, v : Double) -> DbstoregraphTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_table_min(s : DbstoregraphTable) -> Double { @_common.min(s.data) }

pub fn db_store_graph_table_max(s : DbstoregraphTable) -> Double { @_common.max(s.data) }

pub fn db_store_graph_table_to_string(s : DbstoregraphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_graphn_make(size : Int) -> DbstoregraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_graphn_len(s : DbstoregraphGraphN) -> Int { s.size }

pub fn db_store_graph_graphn_get(s : DbstoregraphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_graphn_set(s : DbstoregraphGraphN, i : Int, v : Double) -> DbstoregraphGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_graphn_sum(s : DbstoregraphGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_graphn_mean(s : DbstoregraphGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_graphn_scale(s : DbstoregraphGraphN, f : Double) -> DbstoregraphGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_graphn_add(a : DbstoregraphGraphN, b : DbstoregraphGraphN) -> DbstoregraphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_graphn_copy(s : DbstoregraphGraphN) -> DbstoregraphGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_graphn_fill(s : DbstoregraphGraphN, v : Double) -> DbstoregraphGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_graphn_min(s : DbstoregraphGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_graph_graphn_max(s : DbstoregraphGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_graph_graphn_to_string(s : DbstoregraphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_node_make(size : Int) -> DbstoregraphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_node_len(s : DbstoregraphNode) -> Int { s.size }

pub fn db_store_graph_node_get(s : DbstoregraphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_node_set(s : DbstoregraphNode, i : Int, v : Double) -> DbstoregraphNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_node_sum(s : DbstoregraphNode) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_node_mean(s : DbstoregraphNode) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_node_scale(s : DbstoregraphNode, f : Double) -> DbstoregraphNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_node_add(a : DbstoregraphNode, b : DbstoregraphNode) -> DbstoregraphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_node_copy(s : DbstoregraphNode) -> DbstoregraphNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_node_fill(s : DbstoregraphNode, v : Double) -> DbstoregraphNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_node_min(s : DbstoregraphNode) -> Double { @_common.min(s.data) }

pub fn db_store_graph_node_max(s : DbstoregraphNode) -> Double { @_common.max(s.data) }

pub fn db_store_graph_node_to_string(s : DbstoregraphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_edge_make(size : Int) -> DbstoregraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_edge_len(s : DbstoregraphEdge) -> Int { s.size }

pub fn db_store_graph_edge_get(s : DbstoregraphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_edge_set(s : DbstoregraphEdge, i : Int, v : Double) -> DbstoregraphEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_edge_sum(s : DbstoregraphEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_edge_mean(s : DbstoregraphEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_edge_scale(s : DbstoregraphEdge, f : Double) -> DbstoregraphEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_edge_add(a : DbstoregraphEdge, b : DbstoregraphEdge) -> DbstoregraphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_edge_copy(s : DbstoregraphEdge) -> DbstoregraphEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_edge_fill(s : DbstoregraphEdge, v : Double) -> DbstoregraphEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_edge_min(s : DbstoregraphEdge) -> Double { @_common.min(s.data) }

pub fn db_store_graph_edge_max(s : DbstoregraphEdge) -> Double { @_common.max(s.data) }

pub fn db_store_graph_edge_to_string(s : DbstoregraphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_path_make(size : Int) -> DbstoregraphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_path_len(s : DbstoregraphPath) -> Int { s.size }

pub fn db_store_graph_path_get(s : DbstoregraphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_path_set(s : DbstoregraphPath, i : Int, v : Double) -> DbstoregraphPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_path_sum(s : DbstoregraphPath) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_path_mean(s : DbstoregraphPath) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_path_scale(s : DbstoregraphPath, f : Double) -> DbstoregraphPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_path_add(a : DbstoregraphPath, b : DbstoregraphPath) -> DbstoregraphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_path_copy(s : DbstoregraphPath) -> DbstoregraphPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_path_fill(s : DbstoregraphPath, v : Double) -> DbstoregraphPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_path_min(s : DbstoregraphPath) -> Double { @_common.min(s.data) }

pub fn db_store_graph_path_max(s : DbstoregraphPath) -> Double { @_common.max(s.data) }

pub fn db_store_graph_path_to_string(s : DbstoregraphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cluster_make(size : Int) -> DbstoregraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_cluster_len(s : DbstoregraphCluster) -> Int { s.size }

pub fn db_store_graph_cluster_get(s : DbstoregraphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_cluster_set(s : DbstoregraphCluster, i : Int, v : Double) -> DbstoregraphCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_cluster_sum(s : DbstoregraphCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_cluster_mean(s : DbstoregraphCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_cluster_scale(s : DbstoregraphCluster, f : Double) -> DbstoregraphCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cluster_add(a : DbstoregraphCluster, b : DbstoregraphCluster) -> DbstoregraphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_cluster_copy(s : DbstoregraphCluster) -> DbstoregraphCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cluster_fill(s : DbstoregraphCluster, v : Double) -> DbstoregraphCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cluster_min(s : DbstoregraphCluster) -> Double { @_common.min(s.data) }

pub fn db_store_graph_cluster_max(s : DbstoregraphCluster) -> Double { @_common.max(s.data) }

pub fn db_store_graph_cluster_to_string(s : DbstoregraphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_model_make(size : Int) -> DbstoregraphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_model_len(s : DbstoregraphModel) -> Int { s.size }

pub fn db_store_graph_model_get(s : DbstoregraphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_model_set(s : DbstoregraphModel, i : Int, v : Double) -> DbstoregraphModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_model_sum(s : DbstoregraphModel) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_model_mean(s : DbstoregraphModel) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_model_scale(s : DbstoregraphModel, f : Double) -> DbstoregraphModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_model_add(a : DbstoregraphModel, b : DbstoregraphModel) -> DbstoregraphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_model_copy(s : DbstoregraphModel) -> DbstoregraphModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_model_fill(s : DbstoregraphModel, v : Double) -> DbstoregraphModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_model_min(s : DbstoregraphModel) -> Double { @_common.min(s.data) }

pub fn db_store_graph_model_max(s : DbstoregraphModel) -> Double { @_common.max(s.data) }

pub fn db_store_graph_model_to_string(s : DbstoregraphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_layer_make(size : Int) -> DbstoregraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_layer_len(s : DbstoregraphLayer) -> Int { s.size }

pub fn db_store_graph_layer_get(s : DbstoregraphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_layer_set(s : DbstoregraphLayer, i : Int, v : Double) -> DbstoregraphLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_layer_sum(s : DbstoregraphLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_layer_mean(s : DbstoregraphLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_layer_scale(s : DbstoregraphLayer, f : Double) -> DbstoregraphLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_layer_add(a : DbstoregraphLayer, b : DbstoregraphLayer) -> DbstoregraphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_layer_copy(s : DbstoregraphLayer) -> DbstoregraphLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_layer_fill(s : DbstoregraphLayer, v : Double) -> DbstoregraphLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_layer_min(s : DbstoregraphLayer) -> Double { @_common.min(s.data) }

pub fn db_store_graph_layer_max(s : DbstoregraphLayer) -> Double { @_common.max(s.data) }

pub fn db_store_graph_layer_to_string(s : DbstoregraphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_buffer_make(size : Int) -> DbstoregraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_buffer_len(s : DbstoregraphBuffer) -> Int { s.size }

pub fn db_store_graph_buffer_get(s : DbstoregraphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_buffer_set(s : DbstoregraphBuffer, i : Int, v : Double) -> DbstoregraphBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_buffer_sum(s : DbstoregraphBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_buffer_mean(s : DbstoregraphBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_buffer_scale(s : DbstoregraphBuffer, f : Double) -> DbstoregraphBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_buffer_add(a : DbstoregraphBuffer, b : DbstoregraphBuffer) -> DbstoregraphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_buffer_copy(s : DbstoregraphBuffer) -> DbstoregraphBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_buffer_fill(s : DbstoregraphBuffer, v : Double) -> DbstoregraphBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_buffer_min(s : DbstoregraphBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_graph_buffer_max(s : DbstoregraphBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_graph_buffer_to_string(s : DbstoregraphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cursor_make(size : Int) -> DbstoregraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_cursor_len(s : DbstoregraphCursor) -> Int { s.size }

pub fn db_store_graph_cursor_get(s : DbstoregraphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_cursor_set(s : DbstoregraphCursor, i : Int, v : Double) -> DbstoregraphCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_cursor_sum(s : DbstoregraphCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_cursor_mean(s : DbstoregraphCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_cursor_scale(s : DbstoregraphCursor, f : Double) -> DbstoregraphCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cursor_add(a : DbstoregraphCursor, b : DbstoregraphCursor) -> DbstoregraphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_cursor_copy(s : DbstoregraphCursor) -> DbstoregraphCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cursor_fill(s : DbstoregraphCursor, v : Double) -> DbstoregraphCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_cursor_min(s : DbstoregraphCursor) -> Double { @_common.min(s.data) }

pub fn db_store_graph_cursor_max(s : DbstoregraphCursor) -> Double { @_common.max(s.data) }

pub fn db_store_graph_cursor_to_string(s : DbstoregraphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_view_make(size : Int) -> DbstoregraphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_view_len(s : DbstoregraphView) -> Int { s.size }

pub fn db_store_graph_view_get(s : DbstoregraphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_view_set(s : DbstoregraphView, i : Int, v : Double) -> DbstoregraphView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_view_sum(s : DbstoregraphView) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_view_mean(s : DbstoregraphView) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_view_scale(s : DbstoregraphView, f : Double) -> DbstoregraphView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_view_add(a : DbstoregraphView, b : DbstoregraphView) -> DbstoregraphView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_view_copy(s : DbstoregraphView) -> DbstoregraphView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_view_fill(s : DbstoregraphView, v : Double) -> DbstoregraphView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_view_min(s : DbstoregraphView) -> Double { @_common.min(s.data) }

pub fn db_store_graph_view_max(s : DbstoregraphView) -> Double { @_common.max(s.data) }

pub fn db_store_graph_view_to_string(s : DbstoregraphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_range_make(size : Int) -> DbstoregraphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_range_len(s : DbstoregraphRange) -> Int { s.size }

pub fn db_store_graph_range_get(s : DbstoregraphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_range_set(s : DbstoregraphRange, i : Int, v : Double) -> DbstoregraphRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_range_sum(s : DbstoregraphRange) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_range_mean(s : DbstoregraphRange) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_range_scale(s : DbstoregraphRange, f : Double) -> DbstoregraphRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_range_add(a : DbstoregraphRange, b : DbstoregraphRange) -> DbstoregraphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_range_copy(s : DbstoregraphRange) -> DbstoregraphRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_range_fill(s : DbstoregraphRange, v : Double) -> DbstoregraphRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_range_min(s : DbstoregraphRange) -> Double { @_common.min(s.data) }

pub fn db_store_graph_range_max(s : DbstoregraphRange) -> Double { @_common.max(s.data) }

pub fn db_store_graph_range_to_string(s : DbstoregraphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_slice_make(size : Int) -> DbstoregraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_slice_len(s : DbstoregraphSlice) -> Int { s.size }

pub fn db_store_graph_slice_get(s : DbstoregraphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_slice_set(s : DbstoregraphSlice, i : Int, v : Double) -> DbstoregraphSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_graph_slice_sum(s : DbstoregraphSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_slice_mean(s : DbstoregraphSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_slice_scale(s : DbstoregraphSlice, f : Double) -> DbstoregraphSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_graph_slice_add(a : DbstoregraphSlice, b : DbstoregraphSlice) -> DbstoregraphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_graph_slice_copy(s : DbstoregraphSlice) -> DbstoregraphSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_graph_slice_fill(s : DbstoregraphSlice, v : Double) -> DbstoregraphSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_graph_slice_min(s : DbstoregraphSlice) -> Double { @_common.min(s.data) }

pub fn db_store_graph_slice_max(s : DbstoregraphSlice) -> Double { @_common.max(s.data) }

pub fn db_store_graph_slice_to_string(s : DbstoregraphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

