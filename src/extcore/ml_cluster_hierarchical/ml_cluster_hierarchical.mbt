///===
/// extcore/ml_cluster_hierarchical

pub(all) struct MlclusterhierarchicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_hierarchical_make_point(x : Double, y : Double) -> MlclusterhierarchicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_hierarchical_make_point3(x : Double, y : Double, z : Double) -> MlclusterhierarchicalPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterhierarchicalPoint::x(self : MlclusterhierarchicalPoint) -> Double { self.x }

pub fn MlclusterhierarchicalPoint::y(self : MlclusterhierarchicalPoint) -> Double { self.y }

pub fn MlclusterhierarchicalPoint::z(self : MlclusterhierarchicalPoint) -> Double { self.z }

pub fn MlclusterhierarchicalPoint::label(self : MlclusterhierarchicalPoint) -> Int { self.label }

pub fn MlclusterhierarchicalPoint::dist(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterhierarchicalPoint::add(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::sub(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::scale(self : MlclusterhierarchicalPoint, s : Double) -> MlclusterhierarchicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterhierarchicalPoint::dot(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterhierarchicalPoint::cross(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterhierarchicalPoint::norm(self : MlclusterhierarchicalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterhierarchicalPoint::normalize(self : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterhierarchicalPoint::negate(self : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::mid(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterhierarchicalPoint::lerp(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint, t : Double) -> MlclusterhierarchicalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterhierarchicalPoint::to_string(self : MlclusterhierarchicalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_hierarchical_make_series(vals : Array[Double], name : String) -> MlclusterhierarchicalSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterhierarchicalSeries::len(self : MlclusterhierarchicalSeries) -> Int { self.vals.length() }

pub fn MlclusterhierarchicalSeries::sum(self : MlclusterhierarchicalSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterhierarchicalSeries::mean(self : MlclusterhierarchicalSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterhierarchicalSeries::min(self : MlclusterhierarchicalSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterhierarchicalSeries::max(self : MlclusterhierarchicalSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterhierarchicalSeries::range(self : MlclusterhierarchicalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterhierarchicalSeries::variance(self : MlclusterhierarchicalSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterhierarchicalSeries::std(self : MlclusterhierarchicalSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterhierarchicalSeries::median(self : MlclusterhierarchicalSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterhierarchicalSeries::scale(self : MlclusterhierarchicalSeries, f : Double) -> MlclusterhierarchicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::add(self : MlclusterhierarchicalSeries, other : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::sub(self : MlclusterhierarchicalSeries, other : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::normalize(self : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterhierarchicalSeries::cumsum(self : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::to_string(self : MlclusterhierarchicalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterhierarchicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_hierarchical_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterhierarchicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_hierarchical_matrix_identity(n : Int) -> MlclusterhierarchicalMatrix {
  let m = ml_cluster_hierarchical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterhierarchicalMatrix::get(self : MlclusterhierarchicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterhierarchicalMatrix::transpose(self : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  let result = ml_cluster_hierarchical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterhierarchicalMatrix::add(self : MlclusterhierarchicalMatrix, other : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_hierarchical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterhierarchicalMatrix::scale(self : MlclusterhierarchicalMatrix, s : Double) -> MlclusterhierarchicalMatrix {
  let result = ml_cluster_hierarchical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterhierarchicalMatrix::multiply(self : MlclusterhierarchicalMatrix, other : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  if self.cols != other.rows { return ml_cluster_hierarchical_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_hierarchical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterhierarchicalMatrix::trace(self : MlclusterhierarchicalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterhierarchicalMatrix::det(self : MlclusterhierarchicalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterhierarchicalMatrix::norm(self : MlclusterhierarchicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterhierarchicalMatrix::to_string(self : MlclusterhierarchicalMatrix) -> String {
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

pub(all) struct MlclusterhierarchicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_hierarchical_make_vector(comps : Array[Double]) -> MlclusterhierarchicalVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_hierarchical_vector_zero(dim : Int) -> MlclusterhierarchicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterhierarchicalVector::add(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterhierarchicalVector::sub(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterhierarchicalVector::scale(self : MlclusterhierarchicalVector, s : Double) -> MlclusterhierarchicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterhierarchicalVector::dot(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterhierarchicalVector::norm(self : MlclusterhierarchicalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterhierarchicalVector::normalize(self : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterhierarchicalVector::dist(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterhierarchicalVector::to_string(self : MlclusterhierarchicalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterhierarchicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_frame_make(size : Int) -> MlclusterhierarchicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalFrame::len(self : MlclusterhierarchicalFrame) -> Int { self.size }

pub fn MlclusterhierarchicalFrame::get(self : MlclusterhierarchicalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalFrame::set(self : MlclusterhierarchicalFrame, i : Int, v : Double) -> MlclusterhierarchicalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalFrame::sum(self : MlclusterhierarchicalFrame) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalFrame::mean(self : MlclusterhierarchicalFrame) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalFrame::scale(self : MlclusterhierarchicalFrame, f : Double) -> MlclusterhierarchicalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalFrame::add(self : MlclusterhierarchicalFrame, other : MlclusterhierarchicalFrame) -> MlclusterhierarchicalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalFrame::copy(self : MlclusterhierarchicalFrame) -> MlclusterhierarchicalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalFrame::fill(self : MlclusterhierarchicalFrame, v : Double) -> MlclusterhierarchicalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalFrame::min(self : MlclusterhierarchicalFrame) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalFrame::max(self : MlclusterhierarchicalFrame) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalFrame::to_string(self : MlclusterhierarchicalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_table_make(size : Int) -> MlclusterhierarchicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalTable::len(self : MlclusterhierarchicalTable) -> Int { self.size }

pub fn MlclusterhierarchicalTable::get(self : MlclusterhierarchicalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalTable::set(self : MlclusterhierarchicalTable, i : Int, v : Double) -> MlclusterhierarchicalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalTable::sum(self : MlclusterhierarchicalTable) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalTable::mean(self : MlclusterhierarchicalTable) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalTable::scale(self : MlclusterhierarchicalTable, f : Double) -> MlclusterhierarchicalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalTable::add(self : MlclusterhierarchicalTable, other : MlclusterhierarchicalTable) -> MlclusterhierarchicalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalTable::copy(self : MlclusterhierarchicalTable) -> MlclusterhierarchicalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalTable::fill(self : MlclusterhierarchicalTable, v : Double) -> MlclusterhierarchicalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalTable::min(self : MlclusterhierarchicalTable) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalTable::max(self : MlclusterhierarchicalTable) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalTable::to_string(self : MlclusterhierarchicalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_graphn_make(size : Int) -> MlclusterhierarchicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalGraphN::len(self : MlclusterhierarchicalGraphN) -> Int { self.size }

pub fn MlclusterhierarchicalGraphN::get(self : MlclusterhierarchicalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalGraphN::set(self : MlclusterhierarchicalGraphN, i : Int, v : Double) -> MlclusterhierarchicalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalGraphN::sum(self : MlclusterhierarchicalGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalGraphN::mean(self : MlclusterhierarchicalGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalGraphN::scale(self : MlclusterhierarchicalGraphN, f : Double) -> MlclusterhierarchicalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalGraphN::add(self : MlclusterhierarchicalGraphN, other : MlclusterhierarchicalGraphN) -> MlclusterhierarchicalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalGraphN::copy(self : MlclusterhierarchicalGraphN) -> MlclusterhierarchicalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalGraphN::fill(self : MlclusterhierarchicalGraphN, v : Double) -> MlclusterhierarchicalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalGraphN::min(self : MlclusterhierarchicalGraphN) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalGraphN::max(self : MlclusterhierarchicalGraphN) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalGraphN::to_string(self : MlclusterhierarchicalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_node_make(size : Int) -> MlclusterhierarchicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalNode::len(self : MlclusterhierarchicalNode) -> Int { self.size }

pub fn MlclusterhierarchicalNode::get(self : MlclusterhierarchicalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalNode::set(self : MlclusterhierarchicalNode, i : Int, v : Double) -> MlclusterhierarchicalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalNode::sum(self : MlclusterhierarchicalNode) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalNode::mean(self : MlclusterhierarchicalNode) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalNode::scale(self : MlclusterhierarchicalNode, f : Double) -> MlclusterhierarchicalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalNode::add(self : MlclusterhierarchicalNode, other : MlclusterhierarchicalNode) -> MlclusterhierarchicalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalNode::copy(self : MlclusterhierarchicalNode) -> MlclusterhierarchicalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalNode::fill(self : MlclusterhierarchicalNode, v : Double) -> MlclusterhierarchicalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalNode::min(self : MlclusterhierarchicalNode) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalNode::max(self : MlclusterhierarchicalNode) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalNode::to_string(self : MlclusterhierarchicalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_edge_make(size : Int) -> MlclusterhierarchicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalEdge::len(self : MlclusterhierarchicalEdge) -> Int { self.size }

pub fn MlclusterhierarchicalEdge::get(self : MlclusterhierarchicalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalEdge::set(self : MlclusterhierarchicalEdge, i : Int, v : Double) -> MlclusterhierarchicalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalEdge::sum(self : MlclusterhierarchicalEdge) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalEdge::mean(self : MlclusterhierarchicalEdge) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalEdge::scale(self : MlclusterhierarchicalEdge, f : Double) -> MlclusterhierarchicalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalEdge::add(self : MlclusterhierarchicalEdge, other : MlclusterhierarchicalEdge) -> MlclusterhierarchicalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalEdge::copy(self : MlclusterhierarchicalEdge) -> MlclusterhierarchicalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalEdge::fill(self : MlclusterhierarchicalEdge, v : Double) -> MlclusterhierarchicalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalEdge::min(self : MlclusterhierarchicalEdge) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalEdge::max(self : MlclusterhierarchicalEdge) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalEdge::to_string(self : MlclusterhierarchicalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_path_make(size : Int) -> MlclusterhierarchicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalPath::len(self : MlclusterhierarchicalPath) -> Int { self.size }

pub fn MlclusterhierarchicalPath::get(self : MlclusterhierarchicalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalPath::set(self : MlclusterhierarchicalPath, i : Int, v : Double) -> MlclusterhierarchicalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalPath::sum(self : MlclusterhierarchicalPath) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalPath::mean(self : MlclusterhierarchicalPath) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalPath::scale(self : MlclusterhierarchicalPath, f : Double) -> MlclusterhierarchicalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalPath::add(self : MlclusterhierarchicalPath, other : MlclusterhierarchicalPath) -> MlclusterhierarchicalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalPath::copy(self : MlclusterhierarchicalPath) -> MlclusterhierarchicalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalPath::fill(self : MlclusterhierarchicalPath, v : Double) -> MlclusterhierarchicalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalPath::min(self : MlclusterhierarchicalPath) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalPath::max(self : MlclusterhierarchicalPath) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalPath::to_string(self : MlclusterhierarchicalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_cluster_make(size : Int) -> MlclusterhierarchicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalCluster::len(self : MlclusterhierarchicalCluster) -> Int { self.size }

pub fn MlclusterhierarchicalCluster::get(self : MlclusterhierarchicalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalCluster::set(self : MlclusterhierarchicalCluster, i : Int, v : Double) -> MlclusterhierarchicalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCluster::sum(self : MlclusterhierarchicalCluster) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalCluster::mean(self : MlclusterhierarchicalCluster) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalCluster::scale(self : MlclusterhierarchicalCluster, f : Double) -> MlclusterhierarchicalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCluster::add(self : MlclusterhierarchicalCluster, other : MlclusterhierarchicalCluster) -> MlclusterhierarchicalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalCluster::copy(self : MlclusterhierarchicalCluster) -> MlclusterhierarchicalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCluster::fill(self : MlclusterhierarchicalCluster, v : Double) -> MlclusterhierarchicalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCluster::min(self : MlclusterhierarchicalCluster) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalCluster::max(self : MlclusterhierarchicalCluster) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalCluster::to_string(self : MlclusterhierarchicalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_model_make(size : Int) -> MlclusterhierarchicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalModel::len(self : MlclusterhierarchicalModel) -> Int { self.size }

pub fn MlclusterhierarchicalModel::get(self : MlclusterhierarchicalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalModel::set(self : MlclusterhierarchicalModel, i : Int, v : Double) -> MlclusterhierarchicalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalModel::sum(self : MlclusterhierarchicalModel) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalModel::mean(self : MlclusterhierarchicalModel) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalModel::scale(self : MlclusterhierarchicalModel, f : Double) -> MlclusterhierarchicalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalModel::add(self : MlclusterhierarchicalModel, other : MlclusterhierarchicalModel) -> MlclusterhierarchicalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalModel::copy(self : MlclusterhierarchicalModel) -> MlclusterhierarchicalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalModel::fill(self : MlclusterhierarchicalModel, v : Double) -> MlclusterhierarchicalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalModel::min(self : MlclusterhierarchicalModel) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalModel::max(self : MlclusterhierarchicalModel) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalModel::to_string(self : MlclusterhierarchicalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_layer_make(size : Int) -> MlclusterhierarchicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalLayer::len(self : MlclusterhierarchicalLayer) -> Int { self.size }

pub fn MlclusterhierarchicalLayer::get(self : MlclusterhierarchicalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalLayer::set(self : MlclusterhierarchicalLayer, i : Int, v : Double) -> MlclusterhierarchicalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalLayer::sum(self : MlclusterhierarchicalLayer) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalLayer::mean(self : MlclusterhierarchicalLayer) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalLayer::scale(self : MlclusterhierarchicalLayer, f : Double) -> MlclusterhierarchicalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalLayer::add(self : MlclusterhierarchicalLayer, other : MlclusterhierarchicalLayer) -> MlclusterhierarchicalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalLayer::copy(self : MlclusterhierarchicalLayer) -> MlclusterhierarchicalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalLayer::fill(self : MlclusterhierarchicalLayer, v : Double) -> MlclusterhierarchicalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalLayer::min(self : MlclusterhierarchicalLayer) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalLayer::max(self : MlclusterhierarchicalLayer) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalLayer::to_string(self : MlclusterhierarchicalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_buffer_make(size : Int) -> MlclusterhierarchicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalBuffer::len(self : MlclusterhierarchicalBuffer) -> Int { self.size }

pub fn MlclusterhierarchicalBuffer::get(self : MlclusterhierarchicalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalBuffer::set(self : MlclusterhierarchicalBuffer, i : Int, v : Double) -> MlclusterhierarchicalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalBuffer::sum(self : MlclusterhierarchicalBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalBuffer::mean(self : MlclusterhierarchicalBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalBuffer::scale(self : MlclusterhierarchicalBuffer, f : Double) -> MlclusterhierarchicalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalBuffer::add(self : MlclusterhierarchicalBuffer, other : MlclusterhierarchicalBuffer) -> MlclusterhierarchicalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalBuffer::copy(self : MlclusterhierarchicalBuffer) -> MlclusterhierarchicalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalBuffer::fill(self : MlclusterhierarchicalBuffer, v : Double) -> MlclusterhierarchicalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalBuffer::min(self : MlclusterhierarchicalBuffer) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalBuffer::max(self : MlclusterhierarchicalBuffer) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalBuffer::to_string(self : MlclusterhierarchicalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_cursor_make(size : Int) -> MlclusterhierarchicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalCursor::len(self : MlclusterhierarchicalCursor) -> Int { self.size }

pub fn MlclusterhierarchicalCursor::get(self : MlclusterhierarchicalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalCursor::set(self : MlclusterhierarchicalCursor, i : Int, v : Double) -> MlclusterhierarchicalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCursor::sum(self : MlclusterhierarchicalCursor) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalCursor::mean(self : MlclusterhierarchicalCursor) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalCursor::scale(self : MlclusterhierarchicalCursor, f : Double) -> MlclusterhierarchicalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCursor::add(self : MlclusterhierarchicalCursor, other : MlclusterhierarchicalCursor) -> MlclusterhierarchicalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalCursor::copy(self : MlclusterhierarchicalCursor) -> MlclusterhierarchicalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCursor::fill(self : MlclusterhierarchicalCursor, v : Double) -> MlclusterhierarchicalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalCursor::min(self : MlclusterhierarchicalCursor) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalCursor::max(self : MlclusterhierarchicalCursor) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalCursor::to_string(self : MlclusterhierarchicalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_view_make(size : Int) -> MlclusterhierarchicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalView::len(self : MlclusterhierarchicalView) -> Int { self.size }

pub fn MlclusterhierarchicalView::get(self : MlclusterhierarchicalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalView::set(self : MlclusterhierarchicalView, i : Int, v : Double) -> MlclusterhierarchicalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalView::sum(self : MlclusterhierarchicalView) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalView::mean(self : MlclusterhierarchicalView) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalView::scale(self : MlclusterhierarchicalView, f : Double) -> MlclusterhierarchicalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalView::add(self : MlclusterhierarchicalView, other : MlclusterhierarchicalView) -> MlclusterhierarchicalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalView::copy(self : MlclusterhierarchicalView) -> MlclusterhierarchicalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalView::fill(self : MlclusterhierarchicalView, v : Double) -> MlclusterhierarchicalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalView::min(self : MlclusterhierarchicalView) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalView::max(self : MlclusterhierarchicalView) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalView::to_string(self : MlclusterhierarchicalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_range_make(size : Int) -> MlclusterhierarchicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalRange::len(self : MlclusterhierarchicalRange) -> Int { self.size }

pub fn MlclusterhierarchicalRange::get(self : MlclusterhierarchicalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalRange::set(self : MlclusterhierarchicalRange, i : Int, v : Double) -> MlclusterhierarchicalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalRange::sum(self : MlclusterhierarchicalRange) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalRange::mean(self : MlclusterhierarchicalRange) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalRange::scale(self : MlclusterhierarchicalRange, f : Double) -> MlclusterhierarchicalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalRange::add(self : MlclusterhierarchicalRange, other : MlclusterhierarchicalRange) -> MlclusterhierarchicalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalRange::copy(self : MlclusterhierarchicalRange) -> MlclusterhierarchicalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalRange::fill(self : MlclusterhierarchicalRange, v : Double) -> MlclusterhierarchicalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalRange::min(self : MlclusterhierarchicalRange) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalRange::max(self : MlclusterhierarchicalRange) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalRange::to_string(self : MlclusterhierarchicalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_slice_make(size : Int) -> MlclusterhierarchicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterhierarchicalSlice::len(self : MlclusterhierarchicalSlice) -> Int { self.size }

pub fn MlclusterhierarchicalSlice::get(self : MlclusterhierarchicalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterhierarchicalSlice::set(self : MlclusterhierarchicalSlice, i : Int, v : Double) -> MlclusterhierarchicalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalSlice::sum(self : MlclusterhierarchicalSlice) -> Double { @_common.sum(self.data) }

pub fn MlclusterhierarchicalSlice::mean(self : MlclusterhierarchicalSlice) -> Double { @_common.mean(self.data) }

pub fn MlclusterhierarchicalSlice::scale(self : MlclusterhierarchicalSlice, f : Double) -> MlclusterhierarchicalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalSlice::add(self : MlclusterhierarchicalSlice, other : MlclusterhierarchicalSlice) -> MlclusterhierarchicalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterhierarchicalSlice::copy(self : MlclusterhierarchicalSlice) -> MlclusterhierarchicalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalSlice::fill(self : MlclusterhierarchicalSlice, v : Double) -> MlclusterhierarchicalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterhierarchicalSlice::min(self : MlclusterhierarchicalSlice) -> Double { @_common.min(self.data) }

pub fn MlclusterhierarchicalSlice::max(self : MlclusterhierarchicalSlice) -> Double { @_common.max(self.data) }

pub fn MlclusterhierarchicalSlice::to_string(self : MlclusterhierarchicalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

