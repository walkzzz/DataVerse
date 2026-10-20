///===
/// extcore/ml_cluster_kmeans

pub(all) struct MlclusterkmeansPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_kmeans_make_point(x : Double, y : Double) -> MlclusterkmeansPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_kmeans_make_point3(x : Double, y : Double, z : Double) -> MlclusterkmeansPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterkmeansPoint::x(self : MlclusterkmeansPoint) -> Double { self.x }

pub fn MlclusterkmeansPoint::y(self : MlclusterkmeansPoint) -> Double { self.y }

pub fn MlclusterkmeansPoint::z(self : MlclusterkmeansPoint) -> Double { self.z }

pub fn MlclusterkmeansPoint::label(self : MlclusterkmeansPoint) -> Int { self.label }

pub fn MlclusterkmeansPoint::dist(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterkmeansPoint::add(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterkmeansPoint::sub(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterkmeansPoint::scale(self : MlclusterkmeansPoint, s : Double) -> MlclusterkmeansPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterkmeansPoint::dot(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterkmeansPoint::cross(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterkmeansPoint::norm(self : MlclusterkmeansPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterkmeansPoint::normalize(self : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterkmeansPoint::negate(self : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterkmeansPoint::mid(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterkmeansPoint::lerp(self : MlclusterkmeansPoint, other : MlclusterkmeansPoint, t : Double) -> MlclusterkmeansPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterkmeansPoint::to_string(self : MlclusterkmeansPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterkmeansSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_kmeans_make_series(vals : Array[Double], name : String) -> MlclusterkmeansSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterkmeansSeries::len(self : MlclusterkmeansSeries) -> Int { self.vals.length() }

pub fn MlclusterkmeansSeries::sum(self : MlclusterkmeansSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterkmeansSeries::mean(self : MlclusterkmeansSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterkmeansSeries::min(self : MlclusterkmeansSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterkmeansSeries::max(self : MlclusterkmeansSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterkmeansSeries::range(self : MlclusterkmeansSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterkmeansSeries::variance(self : MlclusterkmeansSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterkmeansSeries::std(self : MlclusterkmeansSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterkmeansSeries::median(self : MlclusterkmeansSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterkmeansSeries::scale(self : MlclusterkmeansSeries, f : Double) -> MlclusterkmeansSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterkmeansSeries::add(self : MlclusterkmeansSeries, other : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterkmeansSeries::sub(self : MlclusterkmeansSeries, other : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterkmeansSeries::normalize(self : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterkmeansSeries::cumsum(self : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterkmeansSeries::to_string(self : MlclusterkmeansSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterkmeansMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_kmeans_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterkmeansMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_kmeans_matrix_identity(n : Int) -> MlclusterkmeansMatrix {
  let m = ml_cluster_kmeans_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterkmeansMatrix::get(self : MlclusterkmeansMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterkmeansMatrix::transpose(self : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterkmeansMatrix::add(self : MlclusterkmeansMatrix, other : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_kmeans_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterkmeansMatrix::scale(self : MlclusterkmeansMatrix, s : Double) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterkmeansMatrix::multiply(self : MlclusterkmeansMatrix, other : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  if self.cols != other.rows { return ml_cluster_kmeans_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_kmeans_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterkmeansMatrix::trace(self : MlclusterkmeansMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterkmeansMatrix::det(self : MlclusterkmeansMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterkmeansMatrix::norm(self : MlclusterkmeansMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterkmeansMatrix::to_string(self : MlclusterkmeansMatrix) -> String {
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

pub(all) struct MlclusterkmeansVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_kmeans_make_vector(comps : Array[Double]) -> MlclusterkmeansVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_kmeans_vector_zero(dim : Int) -> MlclusterkmeansVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterkmeansVector::add(self : MlclusterkmeansVector, other : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterkmeansVector::sub(self : MlclusterkmeansVector, other : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterkmeansVector::scale(self : MlclusterkmeansVector, s : Double) -> MlclusterkmeansVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterkmeansVector::dot(self : MlclusterkmeansVector, other : MlclusterkmeansVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterkmeansVector::norm(self : MlclusterkmeansVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterkmeansVector::normalize(self : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterkmeansVector::dist(self : MlclusterkmeansVector, other : MlclusterkmeansVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterkmeansVector::to_string(self : MlclusterkmeansVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_kmeans_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_kmeans_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_kmeans_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_kmeans_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_kmeans_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_kmeans_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_kmeans_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_kmeans_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_kmeans_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_kmeans_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_kmeans_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_kmeans_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_kmeans_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_kmeans_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_kmeans_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_kmeans_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_kmeans_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_kmeans_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_kmeans_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_kmeans_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_kmeans_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_kmeans_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_kmeans_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_kmeans_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_kmeans_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_kmeans_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_kmeans_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_kmeans_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_kmeans_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterkmeansFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_frame_make(size : Int) -> MlclusterkmeansFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_frame_len(s : MlclusterkmeansFrame) -> Int { s.size }

pub fn ml_cluster_kmeans_frame_get(s : MlclusterkmeansFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_frame_set(s : MlclusterkmeansFrame, i : Int, v : Double) -> MlclusterkmeansFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_frame_sum(s : MlclusterkmeansFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_frame_mean(s : MlclusterkmeansFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_frame_scale(s : MlclusterkmeansFrame, f : Double) -> MlclusterkmeansFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_frame_add(a : MlclusterkmeansFrame, b : MlclusterkmeansFrame) -> MlclusterkmeansFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_frame_copy(s : MlclusterkmeansFrame) -> MlclusterkmeansFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_frame_fill(s : MlclusterkmeansFrame, v : Double) -> MlclusterkmeansFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_frame_min(s : MlclusterkmeansFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_frame_max(s : MlclusterkmeansFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_frame_to_string(s : MlclusterkmeansFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_table_make(size : Int) -> MlclusterkmeansTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_table_len(s : MlclusterkmeansTable) -> Int { s.size }

pub fn ml_cluster_kmeans_table_get(s : MlclusterkmeansTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_table_set(s : MlclusterkmeansTable, i : Int, v : Double) -> MlclusterkmeansTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_table_sum(s : MlclusterkmeansTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_table_mean(s : MlclusterkmeansTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_table_scale(s : MlclusterkmeansTable, f : Double) -> MlclusterkmeansTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_table_add(a : MlclusterkmeansTable, b : MlclusterkmeansTable) -> MlclusterkmeansTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_table_copy(s : MlclusterkmeansTable) -> MlclusterkmeansTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_table_fill(s : MlclusterkmeansTable, v : Double) -> MlclusterkmeansTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_table_min(s : MlclusterkmeansTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_table_max(s : MlclusterkmeansTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_table_to_string(s : MlclusterkmeansTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_graphn_make(size : Int) -> MlclusterkmeansGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_graphn_len(s : MlclusterkmeansGraphN) -> Int { s.size }

pub fn ml_cluster_kmeans_graphn_get(s : MlclusterkmeansGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_graphn_set(s : MlclusterkmeansGraphN, i : Int, v : Double) -> MlclusterkmeansGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_graphn_sum(s : MlclusterkmeansGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_graphn_mean(s : MlclusterkmeansGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_graphn_scale(s : MlclusterkmeansGraphN, f : Double) -> MlclusterkmeansGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_graphn_add(a : MlclusterkmeansGraphN, b : MlclusterkmeansGraphN) -> MlclusterkmeansGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_graphn_copy(s : MlclusterkmeansGraphN) -> MlclusterkmeansGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_graphn_fill(s : MlclusterkmeansGraphN, v : Double) -> MlclusterkmeansGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_graphn_min(s : MlclusterkmeansGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_graphn_max(s : MlclusterkmeansGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_graphn_to_string(s : MlclusterkmeansGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_node_make(size : Int) -> MlclusterkmeansNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_node_len(s : MlclusterkmeansNode) -> Int { s.size }

pub fn ml_cluster_kmeans_node_get(s : MlclusterkmeansNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_node_set(s : MlclusterkmeansNode, i : Int, v : Double) -> MlclusterkmeansNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_node_sum(s : MlclusterkmeansNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_node_mean(s : MlclusterkmeansNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_node_scale(s : MlclusterkmeansNode, f : Double) -> MlclusterkmeansNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_node_add(a : MlclusterkmeansNode, b : MlclusterkmeansNode) -> MlclusterkmeansNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_node_copy(s : MlclusterkmeansNode) -> MlclusterkmeansNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_node_fill(s : MlclusterkmeansNode, v : Double) -> MlclusterkmeansNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_node_min(s : MlclusterkmeansNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_node_max(s : MlclusterkmeansNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_node_to_string(s : MlclusterkmeansNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_edge_make(size : Int) -> MlclusterkmeansEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_edge_len(s : MlclusterkmeansEdge) -> Int { s.size }

pub fn ml_cluster_kmeans_edge_get(s : MlclusterkmeansEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_edge_set(s : MlclusterkmeansEdge, i : Int, v : Double) -> MlclusterkmeansEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_edge_sum(s : MlclusterkmeansEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_edge_mean(s : MlclusterkmeansEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_edge_scale(s : MlclusterkmeansEdge, f : Double) -> MlclusterkmeansEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_edge_add(a : MlclusterkmeansEdge, b : MlclusterkmeansEdge) -> MlclusterkmeansEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_edge_copy(s : MlclusterkmeansEdge) -> MlclusterkmeansEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_edge_fill(s : MlclusterkmeansEdge, v : Double) -> MlclusterkmeansEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_edge_min(s : MlclusterkmeansEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_edge_max(s : MlclusterkmeansEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_edge_to_string(s : MlclusterkmeansEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_path_make(size : Int) -> MlclusterkmeansPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_path_len(s : MlclusterkmeansPath) -> Int { s.size }

pub fn ml_cluster_kmeans_path_get(s : MlclusterkmeansPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_path_set(s : MlclusterkmeansPath, i : Int, v : Double) -> MlclusterkmeansPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_path_sum(s : MlclusterkmeansPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_path_mean(s : MlclusterkmeansPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_path_scale(s : MlclusterkmeansPath, f : Double) -> MlclusterkmeansPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_path_add(a : MlclusterkmeansPath, b : MlclusterkmeansPath) -> MlclusterkmeansPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_path_copy(s : MlclusterkmeansPath) -> MlclusterkmeansPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_path_fill(s : MlclusterkmeansPath, v : Double) -> MlclusterkmeansPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_path_min(s : MlclusterkmeansPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_path_max(s : MlclusterkmeansPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_path_to_string(s : MlclusterkmeansPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_cluster_make(size : Int) -> MlclusterkmeansCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_cluster_len(s : MlclusterkmeansCluster) -> Int { s.size }

pub fn ml_cluster_kmeans_cluster_get(s : MlclusterkmeansCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_cluster_set(s : MlclusterkmeansCluster, i : Int, v : Double) -> MlclusterkmeansCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cluster_sum(s : MlclusterkmeansCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_cluster_mean(s : MlclusterkmeansCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_cluster_scale(s : MlclusterkmeansCluster, f : Double) -> MlclusterkmeansCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cluster_add(a : MlclusterkmeansCluster, b : MlclusterkmeansCluster) -> MlclusterkmeansCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_cluster_copy(s : MlclusterkmeansCluster) -> MlclusterkmeansCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cluster_fill(s : MlclusterkmeansCluster, v : Double) -> MlclusterkmeansCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cluster_min(s : MlclusterkmeansCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_cluster_max(s : MlclusterkmeansCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_cluster_to_string(s : MlclusterkmeansCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_model_make(size : Int) -> MlclusterkmeansModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_model_len(s : MlclusterkmeansModel) -> Int { s.size }

pub fn ml_cluster_kmeans_model_get(s : MlclusterkmeansModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_model_set(s : MlclusterkmeansModel, i : Int, v : Double) -> MlclusterkmeansModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_model_sum(s : MlclusterkmeansModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_model_mean(s : MlclusterkmeansModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_model_scale(s : MlclusterkmeansModel, f : Double) -> MlclusterkmeansModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_model_add(a : MlclusterkmeansModel, b : MlclusterkmeansModel) -> MlclusterkmeansModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_model_copy(s : MlclusterkmeansModel) -> MlclusterkmeansModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_model_fill(s : MlclusterkmeansModel, v : Double) -> MlclusterkmeansModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_model_min(s : MlclusterkmeansModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_model_max(s : MlclusterkmeansModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_model_to_string(s : MlclusterkmeansModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_layer_make(size : Int) -> MlclusterkmeansLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_layer_len(s : MlclusterkmeansLayer) -> Int { s.size }

pub fn ml_cluster_kmeans_layer_get(s : MlclusterkmeansLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_layer_set(s : MlclusterkmeansLayer, i : Int, v : Double) -> MlclusterkmeansLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_layer_sum(s : MlclusterkmeansLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_layer_mean(s : MlclusterkmeansLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_layer_scale(s : MlclusterkmeansLayer, f : Double) -> MlclusterkmeansLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_layer_add(a : MlclusterkmeansLayer, b : MlclusterkmeansLayer) -> MlclusterkmeansLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_layer_copy(s : MlclusterkmeansLayer) -> MlclusterkmeansLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_layer_fill(s : MlclusterkmeansLayer, v : Double) -> MlclusterkmeansLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_layer_min(s : MlclusterkmeansLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_layer_max(s : MlclusterkmeansLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_layer_to_string(s : MlclusterkmeansLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_buffer_make(size : Int) -> MlclusterkmeansBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_buffer_len(s : MlclusterkmeansBuffer) -> Int { s.size }

pub fn ml_cluster_kmeans_buffer_get(s : MlclusterkmeansBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_buffer_set(s : MlclusterkmeansBuffer, i : Int, v : Double) -> MlclusterkmeansBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_buffer_sum(s : MlclusterkmeansBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_buffer_mean(s : MlclusterkmeansBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_buffer_scale(s : MlclusterkmeansBuffer, f : Double) -> MlclusterkmeansBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_buffer_add(a : MlclusterkmeansBuffer, b : MlclusterkmeansBuffer) -> MlclusterkmeansBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_buffer_copy(s : MlclusterkmeansBuffer) -> MlclusterkmeansBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_buffer_fill(s : MlclusterkmeansBuffer, v : Double) -> MlclusterkmeansBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_buffer_min(s : MlclusterkmeansBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_buffer_max(s : MlclusterkmeansBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_buffer_to_string(s : MlclusterkmeansBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_cursor_make(size : Int) -> MlclusterkmeansCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_cursor_len(s : MlclusterkmeansCursor) -> Int { s.size }

pub fn ml_cluster_kmeans_cursor_get(s : MlclusterkmeansCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_cursor_set(s : MlclusterkmeansCursor, i : Int, v : Double) -> MlclusterkmeansCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cursor_sum(s : MlclusterkmeansCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_cursor_mean(s : MlclusterkmeansCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_cursor_scale(s : MlclusterkmeansCursor, f : Double) -> MlclusterkmeansCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cursor_add(a : MlclusterkmeansCursor, b : MlclusterkmeansCursor) -> MlclusterkmeansCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_cursor_copy(s : MlclusterkmeansCursor) -> MlclusterkmeansCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cursor_fill(s : MlclusterkmeansCursor, v : Double) -> MlclusterkmeansCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_cursor_min(s : MlclusterkmeansCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_cursor_max(s : MlclusterkmeansCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_cursor_to_string(s : MlclusterkmeansCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_view_make(size : Int) -> MlclusterkmeansView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_view_len(s : MlclusterkmeansView) -> Int { s.size }

pub fn ml_cluster_kmeans_view_get(s : MlclusterkmeansView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_view_set(s : MlclusterkmeansView, i : Int, v : Double) -> MlclusterkmeansView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_view_sum(s : MlclusterkmeansView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_view_mean(s : MlclusterkmeansView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_view_scale(s : MlclusterkmeansView, f : Double) -> MlclusterkmeansView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_view_add(a : MlclusterkmeansView, b : MlclusterkmeansView) -> MlclusterkmeansView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_view_copy(s : MlclusterkmeansView) -> MlclusterkmeansView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_view_fill(s : MlclusterkmeansView, v : Double) -> MlclusterkmeansView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_view_min(s : MlclusterkmeansView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_view_max(s : MlclusterkmeansView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_view_to_string(s : MlclusterkmeansView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_range_make(size : Int) -> MlclusterkmeansRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_range_len(s : MlclusterkmeansRange) -> Int { s.size }

pub fn ml_cluster_kmeans_range_get(s : MlclusterkmeansRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_range_set(s : MlclusterkmeansRange, i : Int, v : Double) -> MlclusterkmeansRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_range_sum(s : MlclusterkmeansRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_range_mean(s : MlclusterkmeansRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_range_scale(s : MlclusterkmeansRange, f : Double) -> MlclusterkmeansRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_range_add(a : MlclusterkmeansRange, b : MlclusterkmeansRange) -> MlclusterkmeansRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_range_copy(s : MlclusterkmeansRange) -> MlclusterkmeansRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_range_fill(s : MlclusterkmeansRange, v : Double) -> MlclusterkmeansRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_range_min(s : MlclusterkmeansRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_range_max(s : MlclusterkmeansRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_range_to_string(s : MlclusterkmeansRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_slice_make(size : Int) -> MlclusterkmeansSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_slice_len(s : MlclusterkmeansSlice) -> Int { s.size }

pub fn ml_cluster_kmeans_slice_get(s : MlclusterkmeansSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_slice_set(s : MlclusterkmeansSlice, i : Int, v : Double) -> MlclusterkmeansSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_slice_sum(s : MlclusterkmeansSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_kmeans_slice_mean(s : MlclusterkmeansSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_kmeans_slice_scale(s : MlclusterkmeansSlice, f : Double) -> MlclusterkmeansSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_slice_add(a : MlclusterkmeansSlice, b : MlclusterkmeansSlice) -> MlclusterkmeansSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_kmeans_slice_copy(s : MlclusterkmeansSlice) -> MlclusterkmeansSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_slice_fill(s : MlclusterkmeansSlice, v : Double) -> MlclusterkmeansSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_kmeans_slice_min(s : MlclusterkmeansSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_kmeans_slice_max(s : MlclusterkmeansSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_kmeans_slice_to_string(s : MlclusterkmeansSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

