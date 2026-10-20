///===
/// extcore/ml_rl_sac

pub(all) struct MlrlsacPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_sac_make_point(x : Double, y : Double) -> MlrlsacPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_sac_make_point3(x : Double, y : Double, z : Double) -> MlrlsacPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlsacPoint::x(self : MlrlsacPoint) -> Double { self.x }

pub fn MlrlsacPoint::y(self : MlrlsacPoint) -> Double { self.y }

pub fn MlrlsacPoint::z(self : MlrlsacPoint) -> Double { self.z }

pub fn MlrlsacPoint::label(self : MlrlsacPoint) -> Int { self.label }

pub fn MlrlsacPoint::dist(self : MlrlsacPoint, other : MlrlsacPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlsacPoint::add(self : MlrlsacPoint, other : MlrlsacPoint) -> MlrlsacPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlsacPoint::sub(self : MlrlsacPoint, other : MlrlsacPoint) -> MlrlsacPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlsacPoint::scale(self : MlrlsacPoint, s : Double) -> MlrlsacPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlsacPoint::dot(self : MlrlsacPoint, other : MlrlsacPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlsacPoint::cross(self : MlrlsacPoint, other : MlrlsacPoint) -> MlrlsacPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlsacPoint::norm(self : MlrlsacPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlsacPoint::normalize(self : MlrlsacPoint) -> MlrlsacPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlsacPoint::negate(self : MlrlsacPoint) -> MlrlsacPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlsacPoint::mid(self : MlrlsacPoint, other : MlrlsacPoint) -> MlrlsacPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlsacPoint::lerp(self : MlrlsacPoint, other : MlrlsacPoint, t : Double) -> MlrlsacPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlsacPoint::to_string(self : MlrlsacPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlsacSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_sac_make_series(vals : Array[Double], name : String) -> MlrlsacSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlsacSeries::len(self : MlrlsacSeries) -> Int { self.vals.length() }

pub fn MlrlsacSeries::sum(self : MlrlsacSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlsacSeries::mean(self : MlrlsacSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlsacSeries::min(self : MlrlsacSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlsacSeries::max(self : MlrlsacSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlsacSeries::range(self : MlrlsacSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlsacSeries::variance(self : MlrlsacSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlsacSeries::std(self : MlrlsacSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlsacSeries::median(self : MlrlsacSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlsacSeries::scale(self : MlrlsacSeries, f : Double) -> MlrlsacSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlsacSeries::add(self : MlrlsacSeries, other : MlrlsacSeries) -> MlrlsacSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlsacSeries::sub(self : MlrlsacSeries, other : MlrlsacSeries) -> MlrlsacSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlsacSeries::normalize(self : MlrlsacSeries) -> MlrlsacSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlsacSeries::cumsum(self : MlrlsacSeries) -> MlrlsacSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlsacSeries::to_string(self : MlrlsacSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlsacMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_sac_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlsacMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_sac_matrix_identity(n : Int) -> MlrlsacMatrix {
  let m = ml_rl_sac_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlsacMatrix::get(self : MlrlsacMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlsacMatrix::transpose(self : MlrlsacMatrix) -> MlrlsacMatrix {
  let result = ml_rl_sac_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlsacMatrix::add(self : MlrlsacMatrix, other : MlrlsacMatrix) -> MlrlsacMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_sac_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlsacMatrix::scale(self : MlrlsacMatrix, s : Double) -> MlrlsacMatrix {
  let result = ml_rl_sac_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlsacMatrix::multiply(self : MlrlsacMatrix, other : MlrlsacMatrix) -> MlrlsacMatrix {
  if self.cols != other.rows { return ml_rl_sac_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_sac_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlsacMatrix::trace(self : MlrlsacMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlsacMatrix::det(self : MlrlsacMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlsacMatrix::norm(self : MlrlsacMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlsacMatrix::to_string(self : MlrlsacMatrix) -> String {
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

pub(all) struct MlrlsacVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_sac_make_vector(comps : Array[Double]) -> MlrlsacVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_sac_vector_zero(dim : Int) -> MlrlsacVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlsacVector::add(self : MlrlsacVector, other : MlrlsacVector) -> MlrlsacVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlsacVector::sub(self : MlrlsacVector, other : MlrlsacVector) -> MlrlsacVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlsacVector::scale(self : MlrlsacVector, s : Double) -> MlrlsacVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlsacVector::dot(self : MlrlsacVector, other : MlrlsacVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlsacVector::norm(self : MlrlsacVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlsacVector::normalize(self : MlrlsacVector) -> MlrlsacVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlsacVector::dist(self : MlrlsacVector, other : MlrlsacVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlsacVector::to_string(self : MlrlsacVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlsacFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_frame_make(size : Int) -> MlrlsacFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacFrame::len(self : MlrlsacFrame) -> Int { self.size }

pub fn MlrlsacFrame::get(self : MlrlsacFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacFrame::set(self : MlrlsacFrame, i : Int, v : Double) -> MlrlsacFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacFrame::sum(self : MlrlsacFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlsacFrame::mean(self : MlrlsacFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlsacFrame::scale(self : MlrlsacFrame, f : Double) -> MlrlsacFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacFrame::add(self : MlrlsacFrame, other : MlrlsacFrame) -> MlrlsacFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacFrame::copy(self : MlrlsacFrame) -> MlrlsacFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacFrame::fill(self : MlrlsacFrame, v : Double) -> MlrlsacFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacFrame::min(self : MlrlsacFrame) -> Double { @_common.min(self.data) }

pub fn MlrlsacFrame::max(self : MlrlsacFrame) -> Double { @_common.max(self.data) }

pub fn MlrlsacFrame::to_string(self : MlrlsacFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_table_make(size : Int) -> MlrlsacTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacTable::len(self : MlrlsacTable) -> Int { self.size }

pub fn MlrlsacTable::get(self : MlrlsacTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacTable::set(self : MlrlsacTable, i : Int, v : Double) -> MlrlsacTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacTable::sum(self : MlrlsacTable) -> Double { @_common.sum(self.data) }

pub fn MlrlsacTable::mean(self : MlrlsacTable) -> Double { @_common.mean(self.data) }

pub fn MlrlsacTable::scale(self : MlrlsacTable, f : Double) -> MlrlsacTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacTable::add(self : MlrlsacTable, other : MlrlsacTable) -> MlrlsacTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacTable::copy(self : MlrlsacTable) -> MlrlsacTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacTable::fill(self : MlrlsacTable, v : Double) -> MlrlsacTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacTable::min(self : MlrlsacTable) -> Double { @_common.min(self.data) }

pub fn MlrlsacTable::max(self : MlrlsacTable) -> Double { @_common.max(self.data) }

pub fn MlrlsacTable::to_string(self : MlrlsacTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_graphn_make(size : Int) -> MlrlsacGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacGraphN::len(self : MlrlsacGraphN) -> Int { self.size }

pub fn MlrlsacGraphN::get(self : MlrlsacGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacGraphN::set(self : MlrlsacGraphN, i : Int, v : Double) -> MlrlsacGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacGraphN::sum(self : MlrlsacGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlsacGraphN::mean(self : MlrlsacGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlsacGraphN::scale(self : MlrlsacGraphN, f : Double) -> MlrlsacGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacGraphN::add(self : MlrlsacGraphN, other : MlrlsacGraphN) -> MlrlsacGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacGraphN::copy(self : MlrlsacGraphN) -> MlrlsacGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacGraphN::fill(self : MlrlsacGraphN, v : Double) -> MlrlsacGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacGraphN::min(self : MlrlsacGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlsacGraphN::max(self : MlrlsacGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlsacGraphN::to_string(self : MlrlsacGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_node_make(size : Int) -> MlrlsacNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacNode::len(self : MlrlsacNode) -> Int { self.size }

pub fn MlrlsacNode::get(self : MlrlsacNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacNode::set(self : MlrlsacNode, i : Int, v : Double) -> MlrlsacNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacNode::sum(self : MlrlsacNode) -> Double { @_common.sum(self.data) }

pub fn MlrlsacNode::mean(self : MlrlsacNode) -> Double { @_common.mean(self.data) }

pub fn MlrlsacNode::scale(self : MlrlsacNode, f : Double) -> MlrlsacNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacNode::add(self : MlrlsacNode, other : MlrlsacNode) -> MlrlsacNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacNode::copy(self : MlrlsacNode) -> MlrlsacNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacNode::fill(self : MlrlsacNode, v : Double) -> MlrlsacNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacNode::min(self : MlrlsacNode) -> Double { @_common.min(self.data) }

pub fn MlrlsacNode::max(self : MlrlsacNode) -> Double { @_common.max(self.data) }

pub fn MlrlsacNode::to_string(self : MlrlsacNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_edge_make(size : Int) -> MlrlsacEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacEdge::len(self : MlrlsacEdge) -> Int { self.size }

pub fn MlrlsacEdge::get(self : MlrlsacEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacEdge::set(self : MlrlsacEdge, i : Int, v : Double) -> MlrlsacEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacEdge::sum(self : MlrlsacEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlsacEdge::mean(self : MlrlsacEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlsacEdge::scale(self : MlrlsacEdge, f : Double) -> MlrlsacEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacEdge::add(self : MlrlsacEdge, other : MlrlsacEdge) -> MlrlsacEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacEdge::copy(self : MlrlsacEdge) -> MlrlsacEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacEdge::fill(self : MlrlsacEdge, v : Double) -> MlrlsacEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacEdge::min(self : MlrlsacEdge) -> Double { @_common.min(self.data) }

pub fn MlrlsacEdge::max(self : MlrlsacEdge) -> Double { @_common.max(self.data) }

pub fn MlrlsacEdge::to_string(self : MlrlsacEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_path_make(size : Int) -> MlrlsacPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacPath::len(self : MlrlsacPath) -> Int { self.size }

pub fn MlrlsacPath::get(self : MlrlsacPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacPath::set(self : MlrlsacPath, i : Int, v : Double) -> MlrlsacPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacPath::sum(self : MlrlsacPath) -> Double { @_common.sum(self.data) }

pub fn MlrlsacPath::mean(self : MlrlsacPath) -> Double { @_common.mean(self.data) }

pub fn MlrlsacPath::scale(self : MlrlsacPath, f : Double) -> MlrlsacPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacPath::add(self : MlrlsacPath, other : MlrlsacPath) -> MlrlsacPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacPath::copy(self : MlrlsacPath) -> MlrlsacPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacPath::fill(self : MlrlsacPath, v : Double) -> MlrlsacPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacPath::min(self : MlrlsacPath) -> Double { @_common.min(self.data) }

pub fn MlrlsacPath::max(self : MlrlsacPath) -> Double { @_common.max(self.data) }

pub fn MlrlsacPath::to_string(self : MlrlsacPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_cluster_make(size : Int) -> MlrlsacCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacCluster::len(self : MlrlsacCluster) -> Int { self.size }

pub fn MlrlsacCluster::get(self : MlrlsacCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacCluster::set(self : MlrlsacCluster, i : Int, v : Double) -> MlrlsacCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacCluster::sum(self : MlrlsacCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlsacCluster::mean(self : MlrlsacCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlsacCluster::scale(self : MlrlsacCluster, f : Double) -> MlrlsacCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacCluster::add(self : MlrlsacCluster, other : MlrlsacCluster) -> MlrlsacCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacCluster::copy(self : MlrlsacCluster) -> MlrlsacCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacCluster::fill(self : MlrlsacCluster, v : Double) -> MlrlsacCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacCluster::min(self : MlrlsacCluster) -> Double { @_common.min(self.data) }

pub fn MlrlsacCluster::max(self : MlrlsacCluster) -> Double { @_common.max(self.data) }

pub fn MlrlsacCluster::to_string(self : MlrlsacCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_model_make(size : Int) -> MlrlsacModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacModel::len(self : MlrlsacModel) -> Int { self.size }

pub fn MlrlsacModel::get(self : MlrlsacModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacModel::set(self : MlrlsacModel, i : Int, v : Double) -> MlrlsacModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacModel::sum(self : MlrlsacModel) -> Double { @_common.sum(self.data) }

pub fn MlrlsacModel::mean(self : MlrlsacModel) -> Double { @_common.mean(self.data) }

pub fn MlrlsacModel::scale(self : MlrlsacModel, f : Double) -> MlrlsacModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacModel::add(self : MlrlsacModel, other : MlrlsacModel) -> MlrlsacModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacModel::copy(self : MlrlsacModel) -> MlrlsacModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacModel::fill(self : MlrlsacModel, v : Double) -> MlrlsacModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacModel::min(self : MlrlsacModel) -> Double { @_common.min(self.data) }

pub fn MlrlsacModel::max(self : MlrlsacModel) -> Double { @_common.max(self.data) }

pub fn MlrlsacModel::to_string(self : MlrlsacModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_layer_make(size : Int) -> MlrlsacLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacLayer::len(self : MlrlsacLayer) -> Int { self.size }

pub fn MlrlsacLayer::get(self : MlrlsacLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacLayer::set(self : MlrlsacLayer, i : Int, v : Double) -> MlrlsacLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacLayer::sum(self : MlrlsacLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlsacLayer::mean(self : MlrlsacLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlsacLayer::scale(self : MlrlsacLayer, f : Double) -> MlrlsacLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacLayer::add(self : MlrlsacLayer, other : MlrlsacLayer) -> MlrlsacLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacLayer::copy(self : MlrlsacLayer) -> MlrlsacLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacLayer::fill(self : MlrlsacLayer, v : Double) -> MlrlsacLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacLayer::min(self : MlrlsacLayer) -> Double { @_common.min(self.data) }

pub fn MlrlsacLayer::max(self : MlrlsacLayer) -> Double { @_common.max(self.data) }

pub fn MlrlsacLayer::to_string(self : MlrlsacLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_buffer_make(size : Int) -> MlrlsacBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacBuffer::len(self : MlrlsacBuffer) -> Int { self.size }

pub fn MlrlsacBuffer::get(self : MlrlsacBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacBuffer::set(self : MlrlsacBuffer, i : Int, v : Double) -> MlrlsacBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacBuffer::sum(self : MlrlsacBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlsacBuffer::mean(self : MlrlsacBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlsacBuffer::scale(self : MlrlsacBuffer, f : Double) -> MlrlsacBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacBuffer::add(self : MlrlsacBuffer, other : MlrlsacBuffer) -> MlrlsacBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacBuffer::copy(self : MlrlsacBuffer) -> MlrlsacBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacBuffer::fill(self : MlrlsacBuffer, v : Double) -> MlrlsacBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacBuffer::min(self : MlrlsacBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlsacBuffer::max(self : MlrlsacBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlsacBuffer::to_string(self : MlrlsacBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_cursor_make(size : Int) -> MlrlsacCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacCursor::len(self : MlrlsacCursor) -> Int { self.size }

pub fn MlrlsacCursor::get(self : MlrlsacCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacCursor::set(self : MlrlsacCursor, i : Int, v : Double) -> MlrlsacCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacCursor::sum(self : MlrlsacCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlsacCursor::mean(self : MlrlsacCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlsacCursor::scale(self : MlrlsacCursor, f : Double) -> MlrlsacCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacCursor::add(self : MlrlsacCursor, other : MlrlsacCursor) -> MlrlsacCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacCursor::copy(self : MlrlsacCursor) -> MlrlsacCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacCursor::fill(self : MlrlsacCursor, v : Double) -> MlrlsacCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacCursor::min(self : MlrlsacCursor) -> Double { @_common.min(self.data) }

pub fn MlrlsacCursor::max(self : MlrlsacCursor) -> Double { @_common.max(self.data) }

pub fn MlrlsacCursor::to_string(self : MlrlsacCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_view_make(size : Int) -> MlrlsacView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacView::len(self : MlrlsacView) -> Int { self.size }

pub fn MlrlsacView::get(self : MlrlsacView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacView::set(self : MlrlsacView, i : Int, v : Double) -> MlrlsacView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacView::sum(self : MlrlsacView) -> Double { @_common.sum(self.data) }

pub fn MlrlsacView::mean(self : MlrlsacView) -> Double { @_common.mean(self.data) }

pub fn MlrlsacView::scale(self : MlrlsacView, f : Double) -> MlrlsacView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacView::add(self : MlrlsacView, other : MlrlsacView) -> MlrlsacView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacView::copy(self : MlrlsacView) -> MlrlsacView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacView::fill(self : MlrlsacView, v : Double) -> MlrlsacView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacView::min(self : MlrlsacView) -> Double { @_common.min(self.data) }

pub fn MlrlsacView::max(self : MlrlsacView) -> Double { @_common.max(self.data) }

pub fn MlrlsacView::to_string(self : MlrlsacView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_range_make(size : Int) -> MlrlsacRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacRange::len(self : MlrlsacRange) -> Int { self.size }

pub fn MlrlsacRange::get(self : MlrlsacRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacRange::set(self : MlrlsacRange, i : Int, v : Double) -> MlrlsacRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacRange::sum(self : MlrlsacRange) -> Double { @_common.sum(self.data) }

pub fn MlrlsacRange::mean(self : MlrlsacRange) -> Double { @_common.mean(self.data) }

pub fn MlrlsacRange::scale(self : MlrlsacRange, f : Double) -> MlrlsacRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacRange::add(self : MlrlsacRange, other : MlrlsacRange) -> MlrlsacRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacRange::copy(self : MlrlsacRange) -> MlrlsacRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacRange::fill(self : MlrlsacRange, v : Double) -> MlrlsacRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacRange::min(self : MlrlsacRange) -> Double { @_common.min(self.data) }

pub fn MlrlsacRange::max(self : MlrlsacRange) -> Double { @_common.max(self.data) }

pub fn MlrlsacRange::to_string(self : MlrlsacRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlsacSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_slice_make(size : Int) -> MlrlsacSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlsacSlice::len(self : MlrlsacSlice) -> Int { self.size }

pub fn MlrlsacSlice::get(self : MlrlsacSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlsacSlice::set(self : MlrlsacSlice, i : Int, v : Double) -> MlrlsacSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlsacSlice::sum(self : MlrlsacSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlsacSlice::mean(self : MlrlsacSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlsacSlice::scale(self : MlrlsacSlice, f : Double) -> MlrlsacSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlsacSlice::add(self : MlrlsacSlice, other : MlrlsacSlice) -> MlrlsacSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlsacSlice::copy(self : MlrlsacSlice) -> MlrlsacSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlsacSlice::fill(self : MlrlsacSlice, v : Double) -> MlrlsacSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlsacSlice::min(self : MlrlsacSlice) -> Double { @_common.min(self.data) }

pub fn MlrlsacSlice::max(self : MlrlsacSlice) -> Double { @_common.max(self.data) }

pub fn MlrlsacSlice::to_string(self : MlrlsacSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

