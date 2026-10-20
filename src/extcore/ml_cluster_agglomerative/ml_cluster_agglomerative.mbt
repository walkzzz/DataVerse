///===
/// extcore/ml_cluster_agglomerative

pub(all) struct MlclusteragglomerativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_agglomerative_make_point(x : Double, y : Double) -> MlclusteragglomerativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_agglomerative_make_point3(x : Double, y : Double, z : Double) -> MlclusteragglomerativePoint {
  { x, y, z, label: 0 }
}

pub fn MlclusteragglomerativePoint::x(self : MlclusteragglomerativePoint) -> Double { self.x }

pub fn MlclusteragglomerativePoint::y(self : MlclusteragglomerativePoint) -> Double { self.y }

pub fn MlclusteragglomerativePoint::z(self : MlclusteragglomerativePoint) -> Double { self.z }

pub fn MlclusteragglomerativePoint::label(self : MlclusteragglomerativePoint) -> Int { self.label }

pub fn MlclusteragglomerativePoint::dist(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusteragglomerativePoint::add(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::sub(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::scale(self : MlclusteragglomerativePoint, s : Double) -> MlclusteragglomerativePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusteragglomerativePoint::dot(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusteragglomerativePoint::cross(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusteragglomerativePoint::norm(self : MlclusteragglomerativePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusteragglomerativePoint::normalize(self : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteragglomerativePoint::negate(self : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::mid(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusteragglomerativePoint::lerp(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint, t : Double) -> MlclusteragglomerativePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusteragglomerativePoint::to_string(self : MlclusteragglomerativePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_agglomerative_make_series(vals : Array[Double], name : String) -> MlclusteragglomerativeSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusteragglomerativeSeries::len(self : MlclusteragglomerativeSeries) -> Int { self.vals.length() }

pub fn MlclusteragglomerativeSeries::sum(self : MlclusteragglomerativeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusteragglomerativeSeries::mean(self : MlclusteragglomerativeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusteragglomerativeSeries::min(self : MlclusteragglomerativeSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusteragglomerativeSeries::max(self : MlclusteragglomerativeSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusteragglomerativeSeries::range(self : MlclusteragglomerativeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusteragglomerativeSeries::variance(self : MlclusteragglomerativeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusteragglomerativeSeries::std(self : MlclusteragglomerativeSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusteragglomerativeSeries::median(self : MlclusteragglomerativeSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusteragglomerativeSeries::scale(self : MlclusteragglomerativeSeries, f : Double) -> MlclusteragglomerativeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::add(self : MlclusteragglomerativeSeries, other : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::sub(self : MlclusteragglomerativeSeries, other : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::normalize(self : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusteragglomerativeSeries::cumsum(self : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::to_string(self : MlclusteragglomerativeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteragglomerativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_agglomerative_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteragglomerativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_agglomerative_matrix_identity(n : Int) -> MlclusteragglomerativeMatrix {
  let m = ml_cluster_agglomerative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusteragglomerativeMatrix::get(self : MlclusteragglomerativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusteragglomerativeMatrix::transpose(self : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusteragglomerativeMatrix::add(self : MlclusteragglomerativeMatrix, other : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_agglomerative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusteragglomerativeMatrix::scale(self : MlclusteragglomerativeMatrix, s : Double) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusteragglomerativeMatrix::multiply(self : MlclusteragglomerativeMatrix, other : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if self.cols != other.rows { return ml_cluster_agglomerative_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_agglomerative_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusteragglomerativeMatrix::trace(self : MlclusteragglomerativeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusteragglomerativeMatrix::det(self : MlclusteragglomerativeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusteragglomerativeMatrix::norm(self : MlclusteragglomerativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusteragglomerativeMatrix::to_string(self : MlclusteragglomerativeMatrix) -> String {
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

pub(all) struct MlclusteragglomerativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_agglomerative_make_vector(comps : Array[Double]) -> MlclusteragglomerativeVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_agglomerative_vector_zero(dim : Int) -> MlclusteragglomerativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusteragglomerativeVector::add(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteragglomerativeVector::sub(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteragglomerativeVector::scale(self : MlclusteragglomerativeVector, s : Double) -> MlclusteragglomerativeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusteragglomerativeVector::dot(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusteragglomerativeVector::norm(self : MlclusteragglomerativeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusteragglomerativeVector::normalize(self : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteragglomerativeVector::dist(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusteragglomerativeVector::to_string(self : MlclusteragglomerativeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteragglomerativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_frame_make(size : Int) -> MlclusteragglomerativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeFrame::len(self : MlclusteragglomerativeFrame) -> Int { self.size }

pub fn MlclusteragglomerativeFrame::get(self : MlclusteragglomerativeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeFrame::set(self : MlclusteragglomerativeFrame, i : Int, v : Double) -> MlclusteragglomerativeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeFrame::sum(self : MlclusteragglomerativeFrame) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeFrame::mean(self : MlclusteragglomerativeFrame) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeFrame::scale(self : MlclusteragglomerativeFrame, f : Double) -> MlclusteragglomerativeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeFrame::add(self : MlclusteragglomerativeFrame, other : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeFrame::copy(self : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeFrame::fill(self : MlclusteragglomerativeFrame, v : Double) -> MlclusteragglomerativeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeFrame::min(self : MlclusteragglomerativeFrame) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeFrame::max(self : MlclusteragglomerativeFrame) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeFrame::to_string(self : MlclusteragglomerativeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_table_make(size : Int) -> MlclusteragglomerativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeTable::len(self : MlclusteragglomerativeTable) -> Int { self.size }

pub fn MlclusteragglomerativeTable::get(self : MlclusteragglomerativeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeTable::set(self : MlclusteragglomerativeTable, i : Int, v : Double) -> MlclusteragglomerativeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeTable::sum(self : MlclusteragglomerativeTable) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeTable::mean(self : MlclusteragglomerativeTable) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeTable::scale(self : MlclusteragglomerativeTable, f : Double) -> MlclusteragglomerativeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeTable::add(self : MlclusteragglomerativeTable, other : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeTable::copy(self : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeTable::fill(self : MlclusteragglomerativeTable, v : Double) -> MlclusteragglomerativeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeTable::min(self : MlclusteragglomerativeTable) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeTable::max(self : MlclusteragglomerativeTable) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeTable::to_string(self : MlclusteragglomerativeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_graphn_make(size : Int) -> MlclusteragglomerativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeGraphN::len(self : MlclusteragglomerativeGraphN) -> Int { self.size }

pub fn MlclusteragglomerativeGraphN::get(self : MlclusteragglomerativeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeGraphN::set(self : MlclusteragglomerativeGraphN, i : Int, v : Double) -> MlclusteragglomerativeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeGraphN::sum(self : MlclusteragglomerativeGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeGraphN::mean(self : MlclusteragglomerativeGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeGraphN::scale(self : MlclusteragglomerativeGraphN, f : Double) -> MlclusteragglomerativeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeGraphN::add(self : MlclusteragglomerativeGraphN, other : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeGraphN::copy(self : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeGraphN::fill(self : MlclusteragglomerativeGraphN, v : Double) -> MlclusteragglomerativeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeGraphN::min(self : MlclusteragglomerativeGraphN) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeGraphN::max(self : MlclusteragglomerativeGraphN) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeGraphN::to_string(self : MlclusteragglomerativeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_node_make(size : Int) -> MlclusteragglomerativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeNode::len(self : MlclusteragglomerativeNode) -> Int { self.size }

pub fn MlclusteragglomerativeNode::get(self : MlclusteragglomerativeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeNode::set(self : MlclusteragglomerativeNode, i : Int, v : Double) -> MlclusteragglomerativeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeNode::sum(self : MlclusteragglomerativeNode) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeNode::mean(self : MlclusteragglomerativeNode) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeNode::scale(self : MlclusteragglomerativeNode, f : Double) -> MlclusteragglomerativeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeNode::add(self : MlclusteragglomerativeNode, other : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeNode::copy(self : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeNode::fill(self : MlclusteragglomerativeNode, v : Double) -> MlclusteragglomerativeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeNode::min(self : MlclusteragglomerativeNode) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeNode::max(self : MlclusteragglomerativeNode) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeNode::to_string(self : MlclusteragglomerativeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_edge_make(size : Int) -> MlclusteragglomerativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeEdge::len(self : MlclusteragglomerativeEdge) -> Int { self.size }

pub fn MlclusteragglomerativeEdge::get(self : MlclusteragglomerativeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeEdge::set(self : MlclusteragglomerativeEdge, i : Int, v : Double) -> MlclusteragglomerativeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeEdge::sum(self : MlclusteragglomerativeEdge) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeEdge::mean(self : MlclusteragglomerativeEdge) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeEdge::scale(self : MlclusteragglomerativeEdge, f : Double) -> MlclusteragglomerativeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeEdge::add(self : MlclusteragglomerativeEdge, other : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeEdge::copy(self : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeEdge::fill(self : MlclusteragglomerativeEdge, v : Double) -> MlclusteragglomerativeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeEdge::min(self : MlclusteragglomerativeEdge) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeEdge::max(self : MlclusteragglomerativeEdge) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeEdge::to_string(self : MlclusteragglomerativeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_path_make(size : Int) -> MlclusteragglomerativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativePath::len(self : MlclusteragglomerativePath) -> Int { self.size }

pub fn MlclusteragglomerativePath::get(self : MlclusteragglomerativePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativePath::set(self : MlclusteragglomerativePath, i : Int, v : Double) -> MlclusteragglomerativePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativePath::sum(self : MlclusteragglomerativePath) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativePath::mean(self : MlclusteragglomerativePath) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativePath::scale(self : MlclusteragglomerativePath, f : Double) -> MlclusteragglomerativePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativePath::add(self : MlclusteragglomerativePath, other : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativePath::copy(self : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativePath::fill(self : MlclusteragglomerativePath, v : Double) -> MlclusteragglomerativePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativePath::min(self : MlclusteragglomerativePath) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativePath::max(self : MlclusteragglomerativePath) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativePath::to_string(self : MlclusteragglomerativePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cluster_make(size : Int) -> MlclusteragglomerativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeCluster::len(self : MlclusteragglomerativeCluster) -> Int { self.size }

pub fn MlclusteragglomerativeCluster::get(self : MlclusteragglomerativeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeCluster::set(self : MlclusteragglomerativeCluster, i : Int, v : Double) -> MlclusteragglomerativeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCluster::sum(self : MlclusteragglomerativeCluster) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeCluster::mean(self : MlclusteragglomerativeCluster) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeCluster::scale(self : MlclusteragglomerativeCluster, f : Double) -> MlclusteragglomerativeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCluster::add(self : MlclusteragglomerativeCluster, other : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeCluster::copy(self : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCluster::fill(self : MlclusteragglomerativeCluster, v : Double) -> MlclusteragglomerativeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCluster::min(self : MlclusteragglomerativeCluster) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeCluster::max(self : MlclusteragglomerativeCluster) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeCluster::to_string(self : MlclusteragglomerativeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_model_make(size : Int) -> MlclusteragglomerativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeModel::len(self : MlclusteragglomerativeModel) -> Int { self.size }

pub fn MlclusteragglomerativeModel::get(self : MlclusteragglomerativeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeModel::set(self : MlclusteragglomerativeModel, i : Int, v : Double) -> MlclusteragglomerativeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeModel::sum(self : MlclusteragglomerativeModel) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeModel::mean(self : MlclusteragglomerativeModel) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeModel::scale(self : MlclusteragglomerativeModel, f : Double) -> MlclusteragglomerativeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeModel::add(self : MlclusteragglomerativeModel, other : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeModel::copy(self : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeModel::fill(self : MlclusteragglomerativeModel, v : Double) -> MlclusteragglomerativeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeModel::min(self : MlclusteragglomerativeModel) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeModel::max(self : MlclusteragglomerativeModel) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeModel::to_string(self : MlclusteragglomerativeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_layer_make(size : Int) -> MlclusteragglomerativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeLayer::len(self : MlclusteragglomerativeLayer) -> Int { self.size }

pub fn MlclusteragglomerativeLayer::get(self : MlclusteragglomerativeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeLayer::set(self : MlclusteragglomerativeLayer, i : Int, v : Double) -> MlclusteragglomerativeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeLayer::sum(self : MlclusteragglomerativeLayer) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeLayer::mean(self : MlclusteragglomerativeLayer) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeLayer::scale(self : MlclusteragglomerativeLayer, f : Double) -> MlclusteragglomerativeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeLayer::add(self : MlclusteragglomerativeLayer, other : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeLayer::copy(self : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeLayer::fill(self : MlclusteragglomerativeLayer, v : Double) -> MlclusteragglomerativeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeLayer::min(self : MlclusteragglomerativeLayer) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeLayer::max(self : MlclusteragglomerativeLayer) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeLayer::to_string(self : MlclusteragglomerativeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_buffer_make(size : Int) -> MlclusteragglomerativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeBuffer::len(self : MlclusteragglomerativeBuffer) -> Int { self.size }

pub fn MlclusteragglomerativeBuffer::get(self : MlclusteragglomerativeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeBuffer::set(self : MlclusteragglomerativeBuffer, i : Int, v : Double) -> MlclusteragglomerativeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeBuffer::sum(self : MlclusteragglomerativeBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeBuffer::mean(self : MlclusteragglomerativeBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeBuffer::scale(self : MlclusteragglomerativeBuffer, f : Double) -> MlclusteragglomerativeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeBuffer::add(self : MlclusteragglomerativeBuffer, other : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeBuffer::copy(self : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeBuffer::fill(self : MlclusteragglomerativeBuffer, v : Double) -> MlclusteragglomerativeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeBuffer::min(self : MlclusteragglomerativeBuffer) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeBuffer::max(self : MlclusteragglomerativeBuffer) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeBuffer::to_string(self : MlclusteragglomerativeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cursor_make(size : Int) -> MlclusteragglomerativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeCursor::len(self : MlclusteragglomerativeCursor) -> Int { self.size }

pub fn MlclusteragglomerativeCursor::get(self : MlclusteragglomerativeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeCursor::set(self : MlclusteragglomerativeCursor, i : Int, v : Double) -> MlclusteragglomerativeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCursor::sum(self : MlclusteragglomerativeCursor) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeCursor::mean(self : MlclusteragglomerativeCursor) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeCursor::scale(self : MlclusteragglomerativeCursor, f : Double) -> MlclusteragglomerativeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCursor::add(self : MlclusteragglomerativeCursor, other : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeCursor::copy(self : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCursor::fill(self : MlclusteragglomerativeCursor, v : Double) -> MlclusteragglomerativeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeCursor::min(self : MlclusteragglomerativeCursor) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeCursor::max(self : MlclusteragglomerativeCursor) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeCursor::to_string(self : MlclusteragglomerativeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_view_make(size : Int) -> MlclusteragglomerativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeView::len(self : MlclusteragglomerativeView) -> Int { self.size }

pub fn MlclusteragglomerativeView::get(self : MlclusteragglomerativeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeView::set(self : MlclusteragglomerativeView, i : Int, v : Double) -> MlclusteragglomerativeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeView::sum(self : MlclusteragglomerativeView) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeView::mean(self : MlclusteragglomerativeView) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeView::scale(self : MlclusteragglomerativeView, f : Double) -> MlclusteragglomerativeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeView::add(self : MlclusteragglomerativeView, other : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeView::copy(self : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeView::fill(self : MlclusteragglomerativeView, v : Double) -> MlclusteragglomerativeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeView::min(self : MlclusteragglomerativeView) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeView::max(self : MlclusteragglomerativeView) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeView::to_string(self : MlclusteragglomerativeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_range_make(size : Int) -> MlclusteragglomerativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeRange::len(self : MlclusteragglomerativeRange) -> Int { self.size }

pub fn MlclusteragglomerativeRange::get(self : MlclusteragglomerativeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeRange::set(self : MlclusteragglomerativeRange, i : Int, v : Double) -> MlclusteragglomerativeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeRange::sum(self : MlclusteragglomerativeRange) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeRange::mean(self : MlclusteragglomerativeRange) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeRange::scale(self : MlclusteragglomerativeRange, f : Double) -> MlclusteragglomerativeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeRange::add(self : MlclusteragglomerativeRange, other : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeRange::copy(self : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeRange::fill(self : MlclusteragglomerativeRange, v : Double) -> MlclusteragglomerativeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeRange::min(self : MlclusteragglomerativeRange) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeRange::max(self : MlclusteragglomerativeRange) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeRange::to_string(self : MlclusteragglomerativeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_slice_make(size : Int) -> MlclusteragglomerativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteragglomerativeSlice::len(self : MlclusteragglomerativeSlice) -> Int { self.size }

pub fn MlclusteragglomerativeSlice::get(self : MlclusteragglomerativeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteragglomerativeSlice::set(self : MlclusteragglomerativeSlice, i : Int, v : Double) -> MlclusteragglomerativeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeSlice::sum(self : MlclusteragglomerativeSlice) -> Double { @_common.sum(self.data) }

pub fn MlclusteragglomerativeSlice::mean(self : MlclusteragglomerativeSlice) -> Double { @_common.mean(self.data) }

pub fn MlclusteragglomerativeSlice::scale(self : MlclusteragglomerativeSlice, f : Double) -> MlclusteragglomerativeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeSlice::add(self : MlclusteragglomerativeSlice, other : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteragglomerativeSlice::copy(self : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeSlice::fill(self : MlclusteragglomerativeSlice, v : Double) -> MlclusteragglomerativeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteragglomerativeSlice::min(self : MlclusteragglomerativeSlice) -> Double { @_common.min(self.data) }

pub fn MlclusteragglomerativeSlice::max(self : MlclusteragglomerativeSlice) -> Double { @_common.max(self.data) }

pub fn MlclusteragglomerativeSlice::to_string(self : MlclusteragglomerativeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

