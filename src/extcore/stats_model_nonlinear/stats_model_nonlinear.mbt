///===
/// extcore/stats_model_nonlinear

pub(all) struct StatsmodelnonlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_nonlinear_make_point(x : Double, y : Double) -> StatsmodelnonlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_nonlinear_make_point3(x : Double, y : Double, z : Double) -> StatsmodelnonlinearPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodelnonlinearPoint::x(self : StatsmodelnonlinearPoint) -> Double { self.x }

pub fn StatsmodelnonlinearPoint::y(self : StatsmodelnonlinearPoint) -> Double { self.y }

pub fn StatsmodelnonlinearPoint::z(self : StatsmodelnonlinearPoint) -> Double { self.z }

pub fn StatsmodelnonlinearPoint::label(self : StatsmodelnonlinearPoint) -> Int { self.label }

pub fn StatsmodelnonlinearPoint::dist(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodelnonlinearPoint::add(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::sub(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::scale(self : StatsmodelnonlinearPoint, s : Double) -> StatsmodelnonlinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodelnonlinearPoint::dot(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodelnonlinearPoint::cross(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodelnonlinearPoint::norm(self : StatsmodelnonlinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodelnonlinearPoint::normalize(self : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelnonlinearPoint::negate(self : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::mid(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodelnonlinearPoint::lerp(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint, t : Double) -> StatsmodelnonlinearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodelnonlinearPoint::to_string(self : StatsmodelnonlinearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_nonlinear_make_series(vals : Array[Double], name : String) -> StatsmodelnonlinearSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodelnonlinearSeries::len(self : StatsmodelnonlinearSeries) -> Int { self.vals.length() }

pub fn StatsmodelnonlinearSeries::sum(self : StatsmodelnonlinearSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodelnonlinearSeries::mean(self : StatsmodelnonlinearSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodelnonlinearSeries::min(self : StatsmodelnonlinearSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodelnonlinearSeries::max(self : StatsmodelnonlinearSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodelnonlinearSeries::range(self : StatsmodelnonlinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodelnonlinearSeries::variance(self : StatsmodelnonlinearSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodelnonlinearSeries::std(self : StatsmodelnonlinearSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodelnonlinearSeries::median(self : StatsmodelnonlinearSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodelnonlinearSeries::scale(self : StatsmodelnonlinearSeries, f : Double) -> StatsmodelnonlinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::add(self : StatsmodelnonlinearSeries, other : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::sub(self : StatsmodelnonlinearSeries, other : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::normalize(self : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodelnonlinearSeries::cumsum(self : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::to_string(self : StatsmodelnonlinearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelnonlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_nonlinear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelnonlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_nonlinear_matrix_identity(n : Int) -> StatsmodelnonlinearMatrix {
  let m = stats_model_nonlinear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodelnonlinearMatrix::get(self : StatsmodelnonlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodelnonlinearMatrix::transpose(self : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodelnonlinearMatrix::add(self : StatsmodelnonlinearMatrix, other : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_nonlinear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodelnonlinearMatrix::scale(self : StatsmodelnonlinearMatrix, s : Double) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodelnonlinearMatrix::multiply(self : StatsmodelnonlinearMatrix, other : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if self.cols != other.rows { return stats_model_nonlinear_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_nonlinear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsmodelnonlinearMatrix::trace(self : StatsmodelnonlinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodelnonlinearMatrix::det(self : StatsmodelnonlinearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodelnonlinearMatrix::norm(self : StatsmodelnonlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodelnonlinearMatrix::to_string(self : StatsmodelnonlinearMatrix) -> String {
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

pub(all) struct StatsmodelnonlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_nonlinear_make_vector(comps : Array[Double]) -> StatsmodelnonlinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_nonlinear_vector_zero(dim : Int) -> StatsmodelnonlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodelnonlinearVector::add(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelnonlinearVector::sub(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelnonlinearVector::scale(self : StatsmodelnonlinearVector, s : Double) -> StatsmodelnonlinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodelnonlinearVector::dot(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodelnonlinearVector::norm(self : StatsmodelnonlinearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodelnonlinearVector::normalize(self : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelnonlinearVector::dist(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodelnonlinearVector::to_string(self : StatsmodelnonlinearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelnonlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_frame_make(size : Int) -> StatsmodelnonlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearFrame::len(self : StatsmodelnonlinearFrame) -> Int { self.size }

pub fn StatsmodelnonlinearFrame::get(self : StatsmodelnonlinearFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearFrame::set(self : StatsmodelnonlinearFrame, i : Int, v : Double) -> StatsmodelnonlinearFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearFrame::sum(self : StatsmodelnonlinearFrame) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearFrame::mean(self : StatsmodelnonlinearFrame) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearFrame::scale(self : StatsmodelnonlinearFrame, f : Double) -> StatsmodelnonlinearFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearFrame::add(self : StatsmodelnonlinearFrame, other : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearFrame::copy(self : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearFrame::fill(self : StatsmodelnonlinearFrame, v : Double) -> StatsmodelnonlinearFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearFrame::min(self : StatsmodelnonlinearFrame) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearFrame::max(self : StatsmodelnonlinearFrame) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearFrame::to_string(self : StatsmodelnonlinearFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_table_make(size : Int) -> StatsmodelnonlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearTable::len(self : StatsmodelnonlinearTable) -> Int { self.size }

pub fn StatsmodelnonlinearTable::get(self : StatsmodelnonlinearTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearTable::set(self : StatsmodelnonlinearTable, i : Int, v : Double) -> StatsmodelnonlinearTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearTable::sum(self : StatsmodelnonlinearTable) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearTable::mean(self : StatsmodelnonlinearTable) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearTable::scale(self : StatsmodelnonlinearTable, f : Double) -> StatsmodelnonlinearTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearTable::add(self : StatsmodelnonlinearTable, other : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearTable::copy(self : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearTable::fill(self : StatsmodelnonlinearTable, v : Double) -> StatsmodelnonlinearTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearTable::min(self : StatsmodelnonlinearTable) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearTable::max(self : StatsmodelnonlinearTable) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearTable::to_string(self : StatsmodelnonlinearTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_graphn_make(size : Int) -> StatsmodelnonlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearGraphN::len(self : StatsmodelnonlinearGraphN) -> Int { self.size }

pub fn StatsmodelnonlinearGraphN::get(self : StatsmodelnonlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearGraphN::set(self : StatsmodelnonlinearGraphN, i : Int, v : Double) -> StatsmodelnonlinearGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearGraphN::sum(self : StatsmodelnonlinearGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearGraphN::mean(self : StatsmodelnonlinearGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearGraphN::scale(self : StatsmodelnonlinearGraphN, f : Double) -> StatsmodelnonlinearGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearGraphN::add(self : StatsmodelnonlinearGraphN, other : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearGraphN::copy(self : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearGraphN::fill(self : StatsmodelnonlinearGraphN, v : Double) -> StatsmodelnonlinearGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearGraphN::min(self : StatsmodelnonlinearGraphN) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearGraphN::max(self : StatsmodelnonlinearGraphN) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearGraphN::to_string(self : StatsmodelnonlinearGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_node_make(size : Int) -> StatsmodelnonlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearNode::len(self : StatsmodelnonlinearNode) -> Int { self.size }

pub fn StatsmodelnonlinearNode::get(self : StatsmodelnonlinearNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearNode::set(self : StatsmodelnonlinearNode, i : Int, v : Double) -> StatsmodelnonlinearNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearNode::sum(self : StatsmodelnonlinearNode) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearNode::mean(self : StatsmodelnonlinearNode) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearNode::scale(self : StatsmodelnonlinearNode, f : Double) -> StatsmodelnonlinearNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearNode::add(self : StatsmodelnonlinearNode, other : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearNode::copy(self : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearNode::fill(self : StatsmodelnonlinearNode, v : Double) -> StatsmodelnonlinearNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearNode::min(self : StatsmodelnonlinearNode) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearNode::max(self : StatsmodelnonlinearNode) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearNode::to_string(self : StatsmodelnonlinearNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_edge_make(size : Int) -> StatsmodelnonlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearEdge::len(self : StatsmodelnonlinearEdge) -> Int { self.size }

pub fn StatsmodelnonlinearEdge::get(self : StatsmodelnonlinearEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearEdge::set(self : StatsmodelnonlinearEdge, i : Int, v : Double) -> StatsmodelnonlinearEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearEdge::sum(self : StatsmodelnonlinearEdge) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearEdge::mean(self : StatsmodelnonlinearEdge) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearEdge::scale(self : StatsmodelnonlinearEdge, f : Double) -> StatsmodelnonlinearEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearEdge::add(self : StatsmodelnonlinearEdge, other : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearEdge::copy(self : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearEdge::fill(self : StatsmodelnonlinearEdge, v : Double) -> StatsmodelnonlinearEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearEdge::min(self : StatsmodelnonlinearEdge) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearEdge::max(self : StatsmodelnonlinearEdge) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearEdge::to_string(self : StatsmodelnonlinearEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_path_make(size : Int) -> StatsmodelnonlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearPath::len(self : StatsmodelnonlinearPath) -> Int { self.size }

pub fn StatsmodelnonlinearPath::get(self : StatsmodelnonlinearPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearPath::set(self : StatsmodelnonlinearPath, i : Int, v : Double) -> StatsmodelnonlinearPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearPath::sum(self : StatsmodelnonlinearPath) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearPath::mean(self : StatsmodelnonlinearPath) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearPath::scale(self : StatsmodelnonlinearPath, f : Double) -> StatsmodelnonlinearPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearPath::add(self : StatsmodelnonlinearPath, other : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearPath::copy(self : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearPath::fill(self : StatsmodelnonlinearPath, v : Double) -> StatsmodelnonlinearPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearPath::min(self : StatsmodelnonlinearPath) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearPath::max(self : StatsmodelnonlinearPath) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearPath::to_string(self : StatsmodelnonlinearPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cluster_make(size : Int) -> StatsmodelnonlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearCluster::len(self : StatsmodelnonlinearCluster) -> Int { self.size }

pub fn StatsmodelnonlinearCluster::get(self : StatsmodelnonlinearCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearCluster::set(self : StatsmodelnonlinearCluster, i : Int, v : Double) -> StatsmodelnonlinearCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCluster::sum(self : StatsmodelnonlinearCluster) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearCluster::mean(self : StatsmodelnonlinearCluster) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearCluster::scale(self : StatsmodelnonlinearCluster, f : Double) -> StatsmodelnonlinearCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCluster::add(self : StatsmodelnonlinearCluster, other : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearCluster::copy(self : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCluster::fill(self : StatsmodelnonlinearCluster, v : Double) -> StatsmodelnonlinearCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCluster::min(self : StatsmodelnonlinearCluster) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearCluster::max(self : StatsmodelnonlinearCluster) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearCluster::to_string(self : StatsmodelnonlinearCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_model_make(size : Int) -> StatsmodelnonlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearModel::len(self : StatsmodelnonlinearModel) -> Int { self.size }

pub fn StatsmodelnonlinearModel::get(self : StatsmodelnonlinearModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearModel::set(self : StatsmodelnonlinearModel, i : Int, v : Double) -> StatsmodelnonlinearModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearModel::sum(self : StatsmodelnonlinearModel) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearModel::mean(self : StatsmodelnonlinearModel) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearModel::scale(self : StatsmodelnonlinearModel, f : Double) -> StatsmodelnonlinearModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearModel::add(self : StatsmodelnonlinearModel, other : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearModel::copy(self : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearModel::fill(self : StatsmodelnonlinearModel, v : Double) -> StatsmodelnonlinearModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearModel::min(self : StatsmodelnonlinearModel) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearModel::max(self : StatsmodelnonlinearModel) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearModel::to_string(self : StatsmodelnonlinearModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_layer_make(size : Int) -> StatsmodelnonlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearLayer::len(self : StatsmodelnonlinearLayer) -> Int { self.size }

pub fn StatsmodelnonlinearLayer::get(self : StatsmodelnonlinearLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearLayer::set(self : StatsmodelnonlinearLayer, i : Int, v : Double) -> StatsmodelnonlinearLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearLayer::sum(self : StatsmodelnonlinearLayer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearLayer::mean(self : StatsmodelnonlinearLayer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearLayer::scale(self : StatsmodelnonlinearLayer, f : Double) -> StatsmodelnonlinearLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearLayer::add(self : StatsmodelnonlinearLayer, other : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearLayer::copy(self : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearLayer::fill(self : StatsmodelnonlinearLayer, v : Double) -> StatsmodelnonlinearLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearLayer::min(self : StatsmodelnonlinearLayer) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearLayer::max(self : StatsmodelnonlinearLayer) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearLayer::to_string(self : StatsmodelnonlinearLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_buffer_make(size : Int) -> StatsmodelnonlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearBuffer::len(self : StatsmodelnonlinearBuffer) -> Int { self.size }

pub fn StatsmodelnonlinearBuffer::get(self : StatsmodelnonlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearBuffer::set(self : StatsmodelnonlinearBuffer, i : Int, v : Double) -> StatsmodelnonlinearBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearBuffer::sum(self : StatsmodelnonlinearBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearBuffer::mean(self : StatsmodelnonlinearBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearBuffer::scale(self : StatsmodelnonlinearBuffer, f : Double) -> StatsmodelnonlinearBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearBuffer::add(self : StatsmodelnonlinearBuffer, other : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearBuffer::copy(self : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearBuffer::fill(self : StatsmodelnonlinearBuffer, v : Double) -> StatsmodelnonlinearBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearBuffer::min(self : StatsmodelnonlinearBuffer) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearBuffer::max(self : StatsmodelnonlinearBuffer) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearBuffer::to_string(self : StatsmodelnonlinearBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cursor_make(size : Int) -> StatsmodelnonlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearCursor::len(self : StatsmodelnonlinearCursor) -> Int { self.size }

pub fn StatsmodelnonlinearCursor::get(self : StatsmodelnonlinearCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearCursor::set(self : StatsmodelnonlinearCursor, i : Int, v : Double) -> StatsmodelnonlinearCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCursor::sum(self : StatsmodelnonlinearCursor) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearCursor::mean(self : StatsmodelnonlinearCursor) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearCursor::scale(self : StatsmodelnonlinearCursor, f : Double) -> StatsmodelnonlinearCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCursor::add(self : StatsmodelnonlinearCursor, other : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearCursor::copy(self : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCursor::fill(self : StatsmodelnonlinearCursor, v : Double) -> StatsmodelnonlinearCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearCursor::min(self : StatsmodelnonlinearCursor) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearCursor::max(self : StatsmodelnonlinearCursor) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearCursor::to_string(self : StatsmodelnonlinearCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_view_make(size : Int) -> StatsmodelnonlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearView::len(self : StatsmodelnonlinearView) -> Int { self.size }

pub fn StatsmodelnonlinearView::get(self : StatsmodelnonlinearView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearView::set(self : StatsmodelnonlinearView, i : Int, v : Double) -> StatsmodelnonlinearView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearView::sum(self : StatsmodelnonlinearView) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearView::mean(self : StatsmodelnonlinearView) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearView::scale(self : StatsmodelnonlinearView, f : Double) -> StatsmodelnonlinearView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearView::add(self : StatsmodelnonlinearView, other : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearView::copy(self : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearView::fill(self : StatsmodelnonlinearView, v : Double) -> StatsmodelnonlinearView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearView::min(self : StatsmodelnonlinearView) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearView::max(self : StatsmodelnonlinearView) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearView::to_string(self : StatsmodelnonlinearView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_range_make(size : Int) -> StatsmodelnonlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearRange::len(self : StatsmodelnonlinearRange) -> Int { self.size }

pub fn StatsmodelnonlinearRange::get(self : StatsmodelnonlinearRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearRange::set(self : StatsmodelnonlinearRange, i : Int, v : Double) -> StatsmodelnonlinearRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearRange::sum(self : StatsmodelnonlinearRange) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearRange::mean(self : StatsmodelnonlinearRange) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearRange::scale(self : StatsmodelnonlinearRange, f : Double) -> StatsmodelnonlinearRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearRange::add(self : StatsmodelnonlinearRange, other : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearRange::copy(self : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearRange::fill(self : StatsmodelnonlinearRange, v : Double) -> StatsmodelnonlinearRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearRange::min(self : StatsmodelnonlinearRange) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearRange::max(self : StatsmodelnonlinearRange) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearRange::to_string(self : StatsmodelnonlinearRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_slice_make(size : Int) -> StatsmodelnonlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelnonlinearSlice::len(self : StatsmodelnonlinearSlice) -> Int { self.size }

pub fn StatsmodelnonlinearSlice::get(self : StatsmodelnonlinearSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelnonlinearSlice::set(self : StatsmodelnonlinearSlice, i : Int, v : Double) -> StatsmodelnonlinearSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearSlice::sum(self : StatsmodelnonlinearSlice) -> Double { @_common.sum(self.data) }

pub fn StatsmodelnonlinearSlice::mean(self : StatsmodelnonlinearSlice) -> Double { @_common.mean(self.data) }

pub fn StatsmodelnonlinearSlice::scale(self : StatsmodelnonlinearSlice, f : Double) -> StatsmodelnonlinearSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearSlice::add(self : StatsmodelnonlinearSlice, other : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelnonlinearSlice::copy(self : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearSlice::fill(self : StatsmodelnonlinearSlice, v : Double) -> StatsmodelnonlinearSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelnonlinearSlice::min(self : StatsmodelnonlinearSlice) -> Double { @_common.min(self.data) }

pub fn StatsmodelnonlinearSlice::max(self : StatsmodelnonlinearSlice) -> Double { @_common.max(self.data) }

pub fn StatsmodelnonlinearSlice::to_string(self : StatsmodelnonlinearSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

