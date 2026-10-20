///===
/// extcore/ml_ensemble_rf

pub(all) struct MlensemblerfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_rf_make_point(x : Double, y : Double) -> MlensemblerfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_rf_make_point3(x : Double, y : Double, z : Double) -> MlensemblerfPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblerfPoint::x(self : MlensemblerfPoint) -> Double { self.x }

pub fn MlensemblerfPoint::y(self : MlensemblerfPoint) -> Double { self.y }

pub fn MlensemblerfPoint::z(self : MlensemblerfPoint) -> Double { self.z }

pub fn MlensemblerfPoint::label(self : MlensemblerfPoint) -> Int { self.label }

pub fn MlensemblerfPoint::dist(self : MlensemblerfPoint, other : MlensemblerfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblerfPoint::add(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblerfPoint::sub(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblerfPoint::scale(self : MlensemblerfPoint, s : Double) -> MlensemblerfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblerfPoint::dot(self : MlensemblerfPoint, other : MlensemblerfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblerfPoint::cross(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblerfPoint::norm(self : MlensemblerfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblerfPoint::normalize(self : MlensemblerfPoint) -> MlensemblerfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblerfPoint::negate(self : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblerfPoint::mid(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblerfPoint::lerp(self : MlensemblerfPoint, other : MlensemblerfPoint, t : Double) -> MlensemblerfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblerfPoint::to_string(self : MlensemblerfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblerfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_rf_make_series(vals : Array[Double], name : String) -> MlensemblerfSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblerfSeries::len(self : MlensemblerfSeries) -> Int { self.vals.length() }

pub fn MlensemblerfSeries::sum(self : MlensemblerfSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblerfSeries::mean(self : MlensemblerfSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblerfSeries::min(self : MlensemblerfSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblerfSeries::max(self : MlensemblerfSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblerfSeries::range(self : MlensemblerfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblerfSeries::variance(self : MlensemblerfSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblerfSeries::std(self : MlensemblerfSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblerfSeries::median(self : MlensemblerfSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblerfSeries::scale(self : MlensemblerfSeries, f : Double) -> MlensemblerfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblerfSeries::add(self : MlensemblerfSeries, other : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblerfSeries::sub(self : MlensemblerfSeries, other : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblerfSeries::normalize(self : MlensemblerfSeries) -> MlensemblerfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblerfSeries::cumsum(self : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblerfSeries::to_string(self : MlensemblerfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblerfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_rf_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblerfMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_ensemble_rf_matrix_identity(n : Int) -> MlensemblerfMatrix {
  let m = ml_ensemble_rf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblerfMatrix::get(self : MlensemblerfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblerfMatrix::transpose(self : MlensemblerfMatrix) -> MlensemblerfMatrix {
  let result = ml_ensemble_rf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblerfMatrix::add(self : MlensemblerfMatrix, other : MlensemblerfMatrix) -> MlensemblerfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_rf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblerfMatrix::scale(self : MlensemblerfMatrix, s : Double) -> MlensemblerfMatrix {
  let result = ml_ensemble_rf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblerfMatrix::multiply(self : MlensemblerfMatrix, other : MlensemblerfMatrix) -> MlensemblerfMatrix {
  if self.cols != other.rows { return ml_ensemble_rf_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_rf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlensemblerfMatrix::trace(self : MlensemblerfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblerfMatrix::det(self : MlensemblerfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblerfMatrix::norm(self : MlensemblerfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblerfMatrix::to_string(self : MlensemblerfMatrix) -> String {
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

pub(all) struct MlensemblerfVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_rf_make_vector(comps : Array[Double]) -> MlensemblerfVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_rf_vector_zero(dim : Int) -> MlensemblerfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblerfVector::add(self : MlensemblerfVector, other : MlensemblerfVector) -> MlensemblerfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblerfVector::sub(self : MlensemblerfVector, other : MlensemblerfVector) -> MlensemblerfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblerfVector::scale(self : MlensemblerfVector, s : Double) -> MlensemblerfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblerfVector::dot(self : MlensemblerfVector, other : MlensemblerfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblerfVector::norm(self : MlensemblerfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblerfVector::normalize(self : MlensemblerfVector) -> MlensemblerfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblerfVector::dist(self : MlensemblerfVector, other : MlensemblerfVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblerfVector::to_string(self : MlensemblerfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblerfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_frame_make(size : Int) -> MlensemblerfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfFrame::len(self : MlensemblerfFrame) -> Int { self.size }

pub fn MlensemblerfFrame::get(self : MlensemblerfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfFrame::set(self : MlensemblerfFrame, i : Int, v : Double) -> MlensemblerfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfFrame::sum(self : MlensemblerfFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfFrame::mean(self : MlensemblerfFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfFrame::scale(self : MlensemblerfFrame, f : Double) -> MlensemblerfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfFrame::add(self : MlensemblerfFrame, other : MlensemblerfFrame) -> MlensemblerfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfFrame::copy(self : MlensemblerfFrame) -> MlensemblerfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfFrame::fill(self : MlensemblerfFrame, v : Double) -> MlensemblerfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfFrame::min(self : MlensemblerfFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblerfFrame::max(self : MlensemblerfFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblerfFrame::to_string(self : MlensemblerfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_table_make(size : Int) -> MlensemblerfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfTable::len(self : MlensemblerfTable) -> Int { self.size }

pub fn MlensemblerfTable::get(self : MlensemblerfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfTable::set(self : MlensemblerfTable, i : Int, v : Double) -> MlensemblerfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfTable::sum(self : MlensemblerfTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfTable::mean(self : MlensemblerfTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfTable::scale(self : MlensemblerfTable, f : Double) -> MlensemblerfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfTable::add(self : MlensemblerfTable, other : MlensemblerfTable) -> MlensemblerfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfTable::copy(self : MlensemblerfTable) -> MlensemblerfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfTable::fill(self : MlensemblerfTable, v : Double) -> MlensemblerfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfTable::min(self : MlensemblerfTable) -> Double { @_common.min(self.data) }

pub fn MlensemblerfTable::max(self : MlensemblerfTable) -> Double { @_common.max(self.data) }

pub fn MlensemblerfTable::to_string(self : MlensemblerfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_graphn_make(size : Int) -> MlensemblerfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfGraphN::len(self : MlensemblerfGraphN) -> Int { self.size }

pub fn MlensemblerfGraphN::get(self : MlensemblerfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfGraphN::set(self : MlensemblerfGraphN, i : Int, v : Double) -> MlensemblerfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfGraphN::sum(self : MlensemblerfGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfGraphN::mean(self : MlensemblerfGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfGraphN::scale(self : MlensemblerfGraphN, f : Double) -> MlensemblerfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfGraphN::add(self : MlensemblerfGraphN, other : MlensemblerfGraphN) -> MlensemblerfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfGraphN::copy(self : MlensemblerfGraphN) -> MlensemblerfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfGraphN::fill(self : MlensemblerfGraphN, v : Double) -> MlensemblerfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfGraphN::min(self : MlensemblerfGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblerfGraphN::max(self : MlensemblerfGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblerfGraphN::to_string(self : MlensemblerfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_node_make(size : Int) -> MlensemblerfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfNode::len(self : MlensemblerfNode) -> Int { self.size }

pub fn MlensemblerfNode::get(self : MlensemblerfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfNode::set(self : MlensemblerfNode, i : Int, v : Double) -> MlensemblerfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfNode::sum(self : MlensemblerfNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfNode::mean(self : MlensemblerfNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfNode::scale(self : MlensemblerfNode, f : Double) -> MlensemblerfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfNode::add(self : MlensemblerfNode, other : MlensemblerfNode) -> MlensemblerfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfNode::copy(self : MlensemblerfNode) -> MlensemblerfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfNode::fill(self : MlensemblerfNode, v : Double) -> MlensemblerfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfNode::min(self : MlensemblerfNode) -> Double { @_common.min(self.data) }

pub fn MlensemblerfNode::max(self : MlensemblerfNode) -> Double { @_common.max(self.data) }

pub fn MlensemblerfNode::to_string(self : MlensemblerfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_edge_make(size : Int) -> MlensemblerfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfEdge::len(self : MlensemblerfEdge) -> Int { self.size }

pub fn MlensemblerfEdge::get(self : MlensemblerfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfEdge::set(self : MlensemblerfEdge, i : Int, v : Double) -> MlensemblerfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfEdge::sum(self : MlensemblerfEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfEdge::mean(self : MlensemblerfEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfEdge::scale(self : MlensemblerfEdge, f : Double) -> MlensemblerfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfEdge::add(self : MlensemblerfEdge, other : MlensemblerfEdge) -> MlensemblerfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfEdge::copy(self : MlensemblerfEdge) -> MlensemblerfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfEdge::fill(self : MlensemblerfEdge, v : Double) -> MlensemblerfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfEdge::min(self : MlensemblerfEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblerfEdge::max(self : MlensemblerfEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblerfEdge::to_string(self : MlensemblerfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_path_make(size : Int) -> MlensemblerfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfPath::len(self : MlensemblerfPath) -> Int { self.size }

pub fn MlensemblerfPath::get(self : MlensemblerfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfPath::set(self : MlensemblerfPath, i : Int, v : Double) -> MlensemblerfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfPath::sum(self : MlensemblerfPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfPath::mean(self : MlensemblerfPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfPath::scale(self : MlensemblerfPath, f : Double) -> MlensemblerfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfPath::add(self : MlensemblerfPath, other : MlensemblerfPath) -> MlensemblerfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfPath::copy(self : MlensemblerfPath) -> MlensemblerfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfPath::fill(self : MlensemblerfPath, v : Double) -> MlensemblerfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfPath::min(self : MlensemblerfPath) -> Double { @_common.min(self.data) }

pub fn MlensemblerfPath::max(self : MlensemblerfPath) -> Double { @_common.max(self.data) }

pub fn MlensemblerfPath::to_string(self : MlensemblerfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_cluster_make(size : Int) -> MlensemblerfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfCluster::len(self : MlensemblerfCluster) -> Int { self.size }

pub fn MlensemblerfCluster::get(self : MlensemblerfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfCluster::set(self : MlensemblerfCluster, i : Int, v : Double) -> MlensemblerfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfCluster::sum(self : MlensemblerfCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfCluster::mean(self : MlensemblerfCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfCluster::scale(self : MlensemblerfCluster, f : Double) -> MlensemblerfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCluster::add(self : MlensemblerfCluster, other : MlensemblerfCluster) -> MlensemblerfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfCluster::copy(self : MlensemblerfCluster) -> MlensemblerfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCluster::fill(self : MlensemblerfCluster, v : Double) -> MlensemblerfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCluster::min(self : MlensemblerfCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblerfCluster::max(self : MlensemblerfCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblerfCluster::to_string(self : MlensemblerfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_model_make(size : Int) -> MlensemblerfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfModel::len(self : MlensemblerfModel) -> Int { self.size }

pub fn MlensemblerfModel::get(self : MlensemblerfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfModel::set(self : MlensemblerfModel, i : Int, v : Double) -> MlensemblerfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfModel::sum(self : MlensemblerfModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfModel::mean(self : MlensemblerfModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfModel::scale(self : MlensemblerfModel, f : Double) -> MlensemblerfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfModel::add(self : MlensemblerfModel, other : MlensemblerfModel) -> MlensemblerfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfModel::copy(self : MlensemblerfModel) -> MlensemblerfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfModel::fill(self : MlensemblerfModel, v : Double) -> MlensemblerfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfModel::min(self : MlensemblerfModel) -> Double { @_common.min(self.data) }

pub fn MlensemblerfModel::max(self : MlensemblerfModel) -> Double { @_common.max(self.data) }

pub fn MlensemblerfModel::to_string(self : MlensemblerfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_layer_make(size : Int) -> MlensemblerfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfLayer::len(self : MlensemblerfLayer) -> Int { self.size }

pub fn MlensemblerfLayer::get(self : MlensemblerfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfLayer::set(self : MlensemblerfLayer, i : Int, v : Double) -> MlensemblerfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfLayer::sum(self : MlensemblerfLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfLayer::mean(self : MlensemblerfLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfLayer::scale(self : MlensemblerfLayer, f : Double) -> MlensemblerfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfLayer::add(self : MlensemblerfLayer, other : MlensemblerfLayer) -> MlensemblerfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfLayer::copy(self : MlensemblerfLayer) -> MlensemblerfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfLayer::fill(self : MlensemblerfLayer, v : Double) -> MlensemblerfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfLayer::min(self : MlensemblerfLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblerfLayer::max(self : MlensemblerfLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblerfLayer::to_string(self : MlensemblerfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_buffer_make(size : Int) -> MlensemblerfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfBuffer::len(self : MlensemblerfBuffer) -> Int { self.size }

pub fn MlensemblerfBuffer::get(self : MlensemblerfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfBuffer::set(self : MlensemblerfBuffer, i : Int, v : Double) -> MlensemblerfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfBuffer::sum(self : MlensemblerfBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfBuffer::mean(self : MlensemblerfBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfBuffer::scale(self : MlensemblerfBuffer, f : Double) -> MlensemblerfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfBuffer::add(self : MlensemblerfBuffer, other : MlensemblerfBuffer) -> MlensemblerfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfBuffer::copy(self : MlensemblerfBuffer) -> MlensemblerfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfBuffer::fill(self : MlensemblerfBuffer, v : Double) -> MlensemblerfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfBuffer::min(self : MlensemblerfBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblerfBuffer::max(self : MlensemblerfBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblerfBuffer::to_string(self : MlensemblerfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_cursor_make(size : Int) -> MlensemblerfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfCursor::len(self : MlensemblerfCursor) -> Int { self.size }

pub fn MlensemblerfCursor::get(self : MlensemblerfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfCursor::set(self : MlensemblerfCursor, i : Int, v : Double) -> MlensemblerfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfCursor::sum(self : MlensemblerfCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfCursor::mean(self : MlensemblerfCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfCursor::scale(self : MlensemblerfCursor, f : Double) -> MlensemblerfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCursor::add(self : MlensemblerfCursor, other : MlensemblerfCursor) -> MlensemblerfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfCursor::copy(self : MlensemblerfCursor) -> MlensemblerfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCursor::fill(self : MlensemblerfCursor, v : Double) -> MlensemblerfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfCursor::min(self : MlensemblerfCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblerfCursor::max(self : MlensemblerfCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblerfCursor::to_string(self : MlensemblerfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_view_make(size : Int) -> MlensemblerfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfView::len(self : MlensemblerfView) -> Int { self.size }

pub fn MlensemblerfView::get(self : MlensemblerfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfView::set(self : MlensemblerfView, i : Int, v : Double) -> MlensemblerfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfView::sum(self : MlensemblerfView) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfView::mean(self : MlensemblerfView) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfView::scale(self : MlensemblerfView, f : Double) -> MlensemblerfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfView::add(self : MlensemblerfView, other : MlensemblerfView) -> MlensemblerfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfView::copy(self : MlensemblerfView) -> MlensemblerfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfView::fill(self : MlensemblerfView, v : Double) -> MlensemblerfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfView::min(self : MlensemblerfView) -> Double { @_common.min(self.data) }

pub fn MlensemblerfView::max(self : MlensemblerfView) -> Double { @_common.max(self.data) }

pub fn MlensemblerfView::to_string(self : MlensemblerfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_range_make(size : Int) -> MlensemblerfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfRange::len(self : MlensemblerfRange) -> Int { self.size }

pub fn MlensemblerfRange::get(self : MlensemblerfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfRange::set(self : MlensemblerfRange, i : Int, v : Double) -> MlensemblerfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfRange::sum(self : MlensemblerfRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfRange::mean(self : MlensemblerfRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfRange::scale(self : MlensemblerfRange, f : Double) -> MlensemblerfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfRange::add(self : MlensemblerfRange, other : MlensemblerfRange) -> MlensemblerfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfRange::copy(self : MlensemblerfRange) -> MlensemblerfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfRange::fill(self : MlensemblerfRange, v : Double) -> MlensemblerfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfRange::min(self : MlensemblerfRange) -> Double { @_common.min(self.data) }

pub fn MlensemblerfRange::max(self : MlensemblerfRange) -> Double { @_common.max(self.data) }

pub fn MlensemblerfRange::to_string(self : MlensemblerfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblerfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_slice_make(size : Int) -> MlensemblerfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblerfSlice::len(self : MlensemblerfSlice) -> Int { self.size }

pub fn MlensemblerfSlice::get(self : MlensemblerfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblerfSlice::set(self : MlensemblerfSlice, i : Int, v : Double) -> MlensemblerfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblerfSlice::sum(self : MlensemblerfSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblerfSlice::mean(self : MlensemblerfSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblerfSlice::scale(self : MlensemblerfSlice, f : Double) -> MlensemblerfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblerfSlice::add(self : MlensemblerfSlice, other : MlensemblerfSlice) -> MlensemblerfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblerfSlice::copy(self : MlensemblerfSlice) -> MlensemblerfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblerfSlice::fill(self : MlensemblerfSlice, v : Double) -> MlensemblerfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblerfSlice::min(self : MlensemblerfSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblerfSlice::max(self : MlensemblerfSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblerfSlice::to_string(self : MlensemblerfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

