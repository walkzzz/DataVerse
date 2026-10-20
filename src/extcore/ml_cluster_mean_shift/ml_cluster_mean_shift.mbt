///===
/// extcore/ml_cluster_mean_shift

pub(all) struct MlclustermeanshiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_mean_shift_make_point(x : Double, y : Double) -> MlclustermeanshiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_mean_shift_make_point3(x : Double, y : Double, z : Double) -> MlclustermeanshiftPoint {
  { x, y, z, label: 0 }
}

pub fn MlclustermeanshiftPoint::x(self : MlclustermeanshiftPoint) -> Double { self.x }

pub fn MlclustermeanshiftPoint::y(self : MlclustermeanshiftPoint) -> Double { self.y }

pub fn MlclustermeanshiftPoint::z(self : MlclustermeanshiftPoint) -> Double { self.z }

pub fn MlclustermeanshiftPoint::label(self : MlclustermeanshiftPoint) -> Int { self.label }

pub fn MlclustermeanshiftPoint::dist(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclustermeanshiftPoint::add(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::sub(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::scale(self : MlclustermeanshiftPoint, s : Double) -> MlclustermeanshiftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclustermeanshiftPoint::dot(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclustermeanshiftPoint::cross(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclustermeanshiftPoint::norm(self : MlclustermeanshiftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclustermeanshiftPoint::normalize(self : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustermeanshiftPoint::negate(self : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::mid(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclustermeanshiftPoint::lerp(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint, t : Double) -> MlclustermeanshiftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclustermeanshiftPoint::to_string(self : MlclustermeanshiftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_mean_shift_make_series(vals : Array[Double], name : String) -> MlclustermeanshiftSeries {
  { vals, name, meta: 0 }
}

pub fn MlclustermeanshiftSeries::len(self : MlclustermeanshiftSeries) -> Int { self.vals.length() }

pub fn MlclustermeanshiftSeries::sum(self : MlclustermeanshiftSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclustermeanshiftSeries::mean(self : MlclustermeanshiftSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclustermeanshiftSeries::min(self : MlclustermeanshiftSeries) -> Double { @_common.min(self.vals) }

pub fn MlclustermeanshiftSeries::max(self : MlclustermeanshiftSeries) -> Double { @_common.max(self.vals) }

pub fn MlclustermeanshiftSeries::range(self : MlclustermeanshiftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclustermeanshiftSeries::variance(self : MlclustermeanshiftSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclustermeanshiftSeries::std(self : MlclustermeanshiftSeries) -> Double { @_common.std(self.vals) }

pub fn MlclustermeanshiftSeries::median(self : MlclustermeanshiftSeries) -> Double { @_common.median(self.vals) }

pub fn MlclustermeanshiftSeries::scale(self : MlclustermeanshiftSeries, f : Double) -> MlclustermeanshiftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::add(self : MlclustermeanshiftSeries, other : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::sub(self : MlclustermeanshiftSeries, other : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::normalize(self : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclustermeanshiftSeries::cumsum(self : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclustermeanshiftSeries::to_string(self : MlclustermeanshiftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustermeanshiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_mean_shift_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustermeanshiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_mean_shift_matrix_identity(n : Int) -> MlclustermeanshiftMatrix {
  let m = ml_cluster_mean_shift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclustermeanshiftMatrix::get(self : MlclustermeanshiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclustermeanshiftMatrix::transpose(self : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclustermeanshiftMatrix::add(self : MlclustermeanshiftMatrix, other : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_mean_shift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclustermeanshiftMatrix::scale(self : MlclustermeanshiftMatrix, s : Double) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclustermeanshiftMatrix::multiply(self : MlclustermeanshiftMatrix, other : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if self.cols != other.rows { return ml_cluster_mean_shift_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_mean_shift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclustermeanshiftMatrix::trace(self : MlclustermeanshiftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclustermeanshiftMatrix::det(self : MlclustermeanshiftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclustermeanshiftMatrix::norm(self : MlclustermeanshiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclustermeanshiftMatrix::to_string(self : MlclustermeanshiftMatrix) -> String {
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

pub(all) struct MlclustermeanshiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_mean_shift_make_vector(comps : Array[Double]) -> MlclustermeanshiftVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_mean_shift_vector_zero(dim : Int) -> MlclustermeanshiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclustermeanshiftVector::add(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustermeanshiftVector::sub(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustermeanshiftVector::scale(self : MlclustermeanshiftVector, s : Double) -> MlclustermeanshiftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclustermeanshiftVector::dot(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclustermeanshiftVector::norm(self : MlclustermeanshiftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclustermeanshiftVector::normalize(self : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustermeanshiftVector::dist(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclustermeanshiftVector::to_string(self : MlclustermeanshiftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustermeanshiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_frame_make(size : Int) -> MlclustermeanshiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftFrame::len(self : MlclustermeanshiftFrame) -> Int { self.size }

pub fn MlclustermeanshiftFrame::get(self : MlclustermeanshiftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftFrame::set(self : MlclustermeanshiftFrame, i : Int, v : Double) -> MlclustermeanshiftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftFrame::sum(self : MlclustermeanshiftFrame) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftFrame::mean(self : MlclustermeanshiftFrame) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftFrame::scale(self : MlclustermeanshiftFrame, f : Double) -> MlclustermeanshiftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftFrame::add(self : MlclustermeanshiftFrame, other : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftFrame::copy(self : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftFrame::fill(self : MlclustermeanshiftFrame, v : Double) -> MlclustermeanshiftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftFrame::min(self : MlclustermeanshiftFrame) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftFrame::max(self : MlclustermeanshiftFrame) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftFrame::to_string(self : MlclustermeanshiftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_table_make(size : Int) -> MlclustermeanshiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftTable::len(self : MlclustermeanshiftTable) -> Int { self.size }

pub fn MlclustermeanshiftTable::get(self : MlclustermeanshiftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftTable::set(self : MlclustermeanshiftTable, i : Int, v : Double) -> MlclustermeanshiftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftTable::sum(self : MlclustermeanshiftTable) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftTable::mean(self : MlclustermeanshiftTable) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftTable::scale(self : MlclustermeanshiftTable, f : Double) -> MlclustermeanshiftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftTable::add(self : MlclustermeanshiftTable, other : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftTable::copy(self : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftTable::fill(self : MlclustermeanshiftTable, v : Double) -> MlclustermeanshiftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftTable::min(self : MlclustermeanshiftTable) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftTable::max(self : MlclustermeanshiftTable) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftTable::to_string(self : MlclustermeanshiftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_graphn_make(size : Int) -> MlclustermeanshiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftGraphN::len(self : MlclustermeanshiftGraphN) -> Int { self.size }

pub fn MlclustermeanshiftGraphN::get(self : MlclustermeanshiftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftGraphN::set(self : MlclustermeanshiftGraphN, i : Int, v : Double) -> MlclustermeanshiftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftGraphN::sum(self : MlclustermeanshiftGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftGraphN::mean(self : MlclustermeanshiftGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftGraphN::scale(self : MlclustermeanshiftGraphN, f : Double) -> MlclustermeanshiftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftGraphN::add(self : MlclustermeanshiftGraphN, other : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftGraphN::copy(self : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftGraphN::fill(self : MlclustermeanshiftGraphN, v : Double) -> MlclustermeanshiftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftGraphN::min(self : MlclustermeanshiftGraphN) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftGraphN::max(self : MlclustermeanshiftGraphN) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftGraphN::to_string(self : MlclustermeanshiftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_node_make(size : Int) -> MlclustermeanshiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftNode::len(self : MlclustermeanshiftNode) -> Int { self.size }

pub fn MlclustermeanshiftNode::get(self : MlclustermeanshiftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftNode::set(self : MlclustermeanshiftNode, i : Int, v : Double) -> MlclustermeanshiftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftNode::sum(self : MlclustermeanshiftNode) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftNode::mean(self : MlclustermeanshiftNode) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftNode::scale(self : MlclustermeanshiftNode, f : Double) -> MlclustermeanshiftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftNode::add(self : MlclustermeanshiftNode, other : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftNode::copy(self : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftNode::fill(self : MlclustermeanshiftNode, v : Double) -> MlclustermeanshiftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftNode::min(self : MlclustermeanshiftNode) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftNode::max(self : MlclustermeanshiftNode) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftNode::to_string(self : MlclustermeanshiftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_edge_make(size : Int) -> MlclustermeanshiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftEdge::len(self : MlclustermeanshiftEdge) -> Int { self.size }

pub fn MlclustermeanshiftEdge::get(self : MlclustermeanshiftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftEdge::set(self : MlclustermeanshiftEdge, i : Int, v : Double) -> MlclustermeanshiftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftEdge::sum(self : MlclustermeanshiftEdge) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftEdge::mean(self : MlclustermeanshiftEdge) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftEdge::scale(self : MlclustermeanshiftEdge, f : Double) -> MlclustermeanshiftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftEdge::add(self : MlclustermeanshiftEdge, other : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftEdge::copy(self : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftEdge::fill(self : MlclustermeanshiftEdge, v : Double) -> MlclustermeanshiftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftEdge::min(self : MlclustermeanshiftEdge) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftEdge::max(self : MlclustermeanshiftEdge) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftEdge::to_string(self : MlclustermeanshiftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_path_make(size : Int) -> MlclustermeanshiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftPath::len(self : MlclustermeanshiftPath) -> Int { self.size }

pub fn MlclustermeanshiftPath::get(self : MlclustermeanshiftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftPath::set(self : MlclustermeanshiftPath, i : Int, v : Double) -> MlclustermeanshiftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftPath::sum(self : MlclustermeanshiftPath) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftPath::mean(self : MlclustermeanshiftPath) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftPath::scale(self : MlclustermeanshiftPath, f : Double) -> MlclustermeanshiftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftPath::add(self : MlclustermeanshiftPath, other : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftPath::copy(self : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftPath::fill(self : MlclustermeanshiftPath, v : Double) -> MlclustermeanshiftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftPath::min(self : MlclustermeanshiftPath) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftPath::max(self : MlclustermeanshiftPath) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftPath::to_string(self : MlclustermeanshiftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cluster_make(size : Int) -> MlclustermeanshiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftCluster::len(self : MlclustermeanshiftCluster) -> Int { self.size }

pub fn MlclustermeanshiftCluster::get(self : MlclustermeanshiftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftCluster::set(self : MlclustermeanshiftCluster, i : Int, v : Double) -> MlclustermeanshiftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCluster::sum(self : MlclustermeanshiftCluster) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftCluster::mean(self : MlclustermeanshiftCluster) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftCluster::scale(self : MlclustermeanshiftCluster, f : Double) -> MlclustermeanshiftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCluster::add(self : MlclustermeanshiftCluster, other : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftCluster::copy(self : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCluster::fill(self : MlclustermeanshiftCluster, v : Double) -> MlclustermeanshiftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCluster::min(self : MlclustermeanshiftCluster) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftCluster::max(self : MlclustermeanshiftCluster) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftCluster::to_string(self : MlclustermeanshiftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_model_make(size : Int) -> MlclustermeanshiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftModel::len(self : MlclustermeanshiftModel) -> Int { self.size }

pub fn MlclustermeanshiftModel::get(self : MlclustermeanshiftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftModel::set(self : MlclustermeanshiftModel, i : Int, v : Double) -> MlclustermeanshiftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftModel::sum(self : MlclustermeanshiftModel) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftModel::mean(self : MlclustermeanshiftModel) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftModel::scale(self : MlclustermeanshiftModel, f : Double) -> MlclustermeanshiftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftModel::add(self : MlclustermeanshiftModel, other : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftModel::copy(self : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftModel::fill(self : MlclustermeanshiftModel, v : Double) -> MlclustermeanshiftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftModel::min(self : MlclustermeanshiftModel) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftModel::max(self : MlclustermeanshiftModel) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftModel::to_string(self : MlclustermeanshiftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_layer_make(size : Int) -> MlclustermeanshiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftLayer::len(self : MlclustermeanshiftLayer) -> Int { self.size }

pub fn MlclustermeanshiftLayer::get(self : MlclustermeanshiftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftLayer::set(self : MlclustermeanshiftLayer, i : Int, v : Double) -> MlclustermeanshiftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftLayer::sum(self : MlclustermeanshiftLayer) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftLayer::mean(self : MlclustermeanshiftLayer) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftLayer::scale(self : MlclustermeanshiftLayer, f : Double) -> MlclustermeanshiftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftLayer::add(self : MlclustermeanshiftLayer, other : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftLayer::copy(self : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftLayer::fill(self : MlclustermeanshiftLayer, v : Double) -> MlclustermeanshiftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftLayer::min(self : MlclustermeanshiftLayer) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftLayer::max(self : MlclustermeanshiftLayer) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftLayer::to_string(self : MlclustermeanshiftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_buffer_make(size : Int) -> MlclustermeanshiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftBuffer::len(self : MlclustermeanshiftBuffer) -> Int { self.size }

pub fn MlclustermeanshiftBuffer::get(self : MlclustermeanshiftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftBuffer::set(self : MlclustermeanshiftBuffer, i : Int, v : Double) -> MlclustermeanshiftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftBuffer::sum(self : MlclustermeanshiftBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftBuffer::mean(self : MlclustermeanshiftBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftBuffer::scale(self : MlclustermeanshiftBuffer, f : Double) -> MlclustermeanshiftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftBuffer::add(self : MlclustermeanshiftBuffer, other : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftBuffer::copy(self : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftBuffer::fill(self : MlclustermeanshiftBuffer, v : Double) -> MlclustermeanshiftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftBuffer::min(self : MlclustermeanshiftBuffer) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftBuffer::max(self : MlclustermeanshiftBuffer) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftBuffer::to_string(self : MlclustermeanshiftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cursor_make(size : Int) -> MlclustermeanshiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftCursor::len(self : MlclustermeanshiftCursor) -> Int { self.size }

pub fn MlclustermeanshiftCursor::get(self : MlclustermeanshiftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftCursor::set(self : MlclustermeanshiftCursor, i : Int, v : Double) -> MlclustermeanshiftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCursor::sum(self : MlclustermeanshiftCursor) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftCursor::mean(self : MlclustermeanshiftCursor) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftCursor::scale(self : MlclustermeanshiftCursor, f : Double) -> MlclustermeanshiftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCursor::add(self : MlclustermeanshiftCursor, other : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftCursor::copy(self : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCursor::fill(self : MlclustermeanshiftCursor, v : Double) -> MlclustermeanshiftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftCursor::min(self : MlclustermeanshiftCursor) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftCursor::max(self : MlclustermeanshiftCursor) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftCursor::to_string(self : MlclustermeanshiftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_view_make(size : Int) -> MlclustermeanshiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftView::len(self : MlclustermeanshiftView) -> Int { self.size }

pub fn MlclustermeanshiftView::get(self : MlclustermeanshiftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftView::set(self : MlclustermeanshiftView, i : Int, v : Double) -> MlclustermeanshiftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftView::sum(self : MlclustermeanshiftView) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftView::mean(self : MlclustermeanshiftView) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftView::scale(self : MlclustermeanshiftView, f : Double) -> MlclustermeanshiftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftView::add(self : MlclustermeanshiftView, other : MlclustermeanshiftView) -> MlclustermeanshiftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftView::copy(self : MlclustermeanshiftView) -> MlclustermeanshiftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftView::fill(self : MlclustermeanshiftView, v : Double) -> MlclustermeanshiftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftView::min(self : MlclustermeanshiftView) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftView::max(self : MlclustermeanshiftView) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftView::to_string(self : MlclustermeanshiftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_range_make(size : Int) -> MlclustermeanshiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftRange::len(self : MlclustermeanshiftRange) -> Int { self.size }

pub fn MlclustermeanshiftRange::get(self : MlclustermeanshiftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftRange::set(self : MlclustermeanshiftRange, i : Int, v : Double) -> MlclustermeanshiftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftRange::sum(self : MlclustermeanshiftRange) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftRange::mean(self : MlclustermeanshiftRange) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftRange::scale(self : MlclustermeanshiftRange, f : Double) -> MlclustermeanshiftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftRange::add(self : MlclustermeanshiftRange, other : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftRange::copy(self : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftRange::fill(self : MlclustermeanshiftRange, v : Double) -> MlclustermeanshiftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftRange::min(self : MlclustermeanshiftRange) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftRange::max(self : MlclustermeanshiftRange) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftRange::to_string(self : MlclustermeanshiftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_slice_make(size : Int) -> MlclustermeanshiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustermeanshiftSlice::len(self : MlclustermeanshiftSlice) -> Int { self.size }

pub fn MlclustermeanshiftSlice::get(self : MlclustermeanshiftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustermeanshiftSlice::set(self : MlclustermeanshiftSlice, i : Int, v : Double) -> MlclustermeanshiftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftSlice::sum(self : MlclustermeanshiftSlice) -> Double { @_common.sum(self.data) }

pub fn MlclustermeanshiftSlice::mean(self : MlclustermeanshiftSlice) -> Double { @_common.mean(self.data) }

pub fn MlclustermeanshiftSlice::scale(self : MlclustermeanshiftSlice, f : Double) -> MlclustermeanshiftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftSlice::add(self : MlclustermeanshiftSlice, other : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustermeanshiftSlice::copy(self : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftSlice::fill(self : MlclustermeanshiftSlice, v : Double) -> MlclustermeanshiftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustermeanshiftSlice::min(self : MlclustermeanshiftSlice) -> Double { @_common.min(self.data) }

pub fn MlclustermeanshiftSlice::max(self : MlclustermeanshiftSlice) -> Double { @_common.max(self.data) }

pub fn MlclustermeanshiftSlice::to_string(self : MlclustermeanshiftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

