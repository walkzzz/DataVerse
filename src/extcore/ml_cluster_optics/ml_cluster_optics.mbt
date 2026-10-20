///===
/// extcore/ml_cluster_optics

pub(all) struct MlclusteropticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_optics_make_point(x : Double, y : Double) -> MlclusteropticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_optics_make_point3(x : Double, y : Double, z : Double) -> MlclusteropticsPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusteropticsPoint::x(self : MlclusteropticsPoint) -> Double { self.x }

pub fn MlclusteropticsPoint::y(self : MlclusteropticsPoint) -> Double { self.y }

pub fn MlclusteropticsPoint::z(self : MlclusteropticsPoint) -> Double { self.z }

pub fn MlclusteropticsPoint::label(self : MlclusteropticsPoint) -> Int { self.label }

pub fn MlclusteropticsPoint::dist(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusteropticsPoint::add(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusteropticsPoint::sub(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusteropticsPoint::scale(self : MlclusteropticsPoint, s : Double) -> MlclusteropticsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusteropticsPoint::dot(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusteropticsPoint::cross(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusteropticsPoint::norm(self : MlclusteropticsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusteropticsPoint::normalize(self : MlclusteropticsPoint) -> MlclusteropticsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteropticsPoint::negate(self : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusteropticsPoint::mid(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusteropticsPoint::lerp(self : MlclusteropticsPoint, other : MlclusteropticsPoint, t : Double) -> MlclusteropticsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusteropticsPoint::to_string(self : MlclusteropticsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusteropticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_optics_make_series(vals : Array[Double], name : String) -> MlclusteropticsSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusteropticsSeries::len(self : MlclusteropticsSeries) -> Int { self.vals.length() }

pub fn MlclusteropticsSeries::sum(self : MlclusteropticsSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusteropticsSeries::mean(self : MlclusteropticsSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusteropticsSeries::min(self : MlclusteropticsSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusteropticsSeries::max(self : MlclusteropticsSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusteropticsSeries::range(self : MlclusteropticsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusteropticsSeries::variance(self : MlclusteropticsSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusteropticsSeries::std(self : MlclusteropticsSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusteropticsSeries::median(self : MlclusteropticsSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusteropticsSeries::scale(self : MlclusteropticsSeries, f : Double) -> MlclusteropticsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::add(self : MlclusteropticsSeries, other : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::sub(self : MlclusteropticsSeries, other : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::normalize(self : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusteropticsSeries::cumsum(self : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusteropticsSeries::to_string(self : MlclusteropticsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteropticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_optics_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteropticsMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_cluster_optics_matrix_identity(n : Int) -> MlclusteropticsMatrix {
  let m = ml_cluster_optics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusteropticsMatrix::get(self : MlclusteropticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusteropticsMatrix::transpose(self : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusteropticsMatrix::add(self : MlclusteropticsMatrix, other : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_optics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusteropticsMatrix::scale(self : MlclusteropticsMatrix, s : Double) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusteropticsMatrix::multiply(self : MlclusteropticsMatrix, other : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if self.cols != other.rows { return ml_cluster_optics_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_optics_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclusteropticsMatrix::trace(self : MlclusteropticsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusteropticsMatrix::det(self : MlclusteropticsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusteropticsMatrix::norm(self : MlclusteropticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusteropticsMatrix::to_string(self : MlclusteropticsMatrix) -> String {
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

pub(all) struct MlclusteropticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_optics_make_vector(comps : Array[Double]) -> MlclusteropticsVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_optics_vector_zero(dim : Int) -> MlclusteropticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusteropticsVector::add(self : MlclusteropticsVector, other : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteropticsVector::sub(self : MlclusteropticsVector, other : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteropticsVector::scale(self : MlclusteropticsVector, s : Double) -> MlclusteropticsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusteropticsVector::dot(self : MlclusteropticsVector, other : MlclusteropticsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusteropticsVector::norm(self : MlclusteropticsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusteropticsVector::normalize(self : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteropticsVector::dist(self : MlclusteropticsVector, other : MlclusteropticsVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusteropticsVector::to_string(self : MlclusteropticsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteropticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_frame_make(size : Int) -> MlclusteropticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsFrame::len(self : MlclusteropticsFrame) -> Int { self.size }

pub fn MlclusteropticsFrame::get(self : MlclusteropticsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsFrame::set(self : MlclusteropticsFrame, i : Int, v : Double) -> MlclusteropticsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsFrame::sum(self : MlclusteropticsFrame) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsFrame::mean(self : MlclusteropticsFrame) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsFrame::scale(self : MlclusteropticsFrame, f : Double) -> MlclusteropticsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsFrame::add(self : MlclusteropticsFrame, other : MlclusteropticsFrame) -> MlclusteropticsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsFrame::copy(self : MlclusteropticsFrame) -> MlclusteropticsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsFrame::fill(self : MlclusteropticsFrame, v : Double) -> MlclusteropticsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsFrame::min(self : MlclusteropticsFrame) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsFrame::max(self : MlclusteropticsFrame) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsFrame::to_string(self : MlclusteropticsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_table_make(size : Int) -> MlclusteropticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsTable::len(self : MlclusteropticsTable) -> Int { self.size }

pub fn MlclusteropticsTable::get(self : MlclusteropticsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsTable::set(self : MlclusteropticsTable, i : Int, v : Double) -> MlclusteropticsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsTable::sum(self : MlclusteropticsTable) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsTable::mean(self : MlclusteropticsTable) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsTable::scale(self : MlclusteropticsTable, f : Double) -> MlclusteropticsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsTable::add(self : MlclusteropticsTable, other : MlclusteropticsTable) -> MlclusteropticsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsTable::copy(self : MlclusteropticsTable) -> MlclusteropticsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsTable::fill(self : MlclusteropticsTable, v : Double) -> MlclusteropticsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsTable::min(self : MlclusteropticsTable) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsTable::max(self : MlclusteropticsTable) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsTable::to_string(self : MlclusteropticsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_graphn_make(size : Int) -> MlclusteropticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsGraphN::len(self : MlclusteropticsGraphN) -> Int { self.size }

pub fn MlclusteropticsGraphN::get(self : MlclusteropticsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsGraphN::set(self : MlclusteropticsGraphN, i : Int, v : Double) -> MlclusteropticsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsGraphN::sum(self : MlclusteropticsGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsGraphN::mean(self : MlclusteropticsGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsGraphN::scale(self : MlclusteropticsGraphN, f : Double) -> MlclusteropticsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsGraphN::add(self : MlclusteropticsGraphN, other : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsGraphN::copy(self : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsGraphN::fill(self : MlclusteropticsGraphN, v : Double) -> MlclusteropticsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsGraphN::min(self : MlclusteropticsGraphN) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsGraphN::max(self : MlclusteropticsGraphN) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsGraphN::to_string(self : MlclusteropticsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_node_make(size : Int) -> MlclusteropticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsNode::len(self : MlclusteropticsNode) -> Int { self.size }

pub fn MlclusteropticsNode::get(self : MlclusteropticsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsNode::set(self : MlclusteropticsNode, i : Int, v : Double) -> MlclusteropticsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsNode::sum(self : MlclusteropticsNode) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsNode::mean(self : MlclusteropticsNode) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsNode::scale(self : MlclusteropticsNode, f : Double) -> MlclusteropticsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsNode::add(self : MlclusteropticsNode, other : MlclusteropticsNode) -> MlclusteropticsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsNode::copy(self : MlclusteropticsNode) -> MlclusteropticsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsNode::fill(self : MlclusteropticsNode, v : Double) -> MlclusteropticsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsNode::min(self : MlclusteropticsNode) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsNode::max(self : MlclusteropticsNode) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsNode::to_string(self : MlclusteropticsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_edge_make(size : Int) -> MlclusteropticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsEdge::len(self : MlclusteropticsEdge) -> Int { self.size }

pub fn MlclusteropticsEdge::get(self : MlclusteropticsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsEdge::set(self : MlclusteropticsEdge, i : Int, v : Double) -> MlclusteropticsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsEdge::sum(self : MlclusteropticsEdge) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsEdge::mean(self : MlclusteropticsEdge) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsEdge::scale(self : MlclusteropticsEdge, f : Double) -> MlclusteropticsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsEdge::add(self : MlclusteropticsEdge, other : MlclusteropticsEdge) -> MlclusteropticsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsEdge::copy(self : MlclusteropticsEdge) -> MlclusteropticsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsEdge::fill(self : MlclusteropticsEdge, v : Double) -> MlclusteropticsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsEdge::min(self : MlclusteropticsEdge) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsEdge::max(self : MlclusteropticsEdge) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsEdge::to_string(self : MlclusteropticsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_path_make(size : Int) -> MlclusteropticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsPath::len(self : MlclusteropticsPath) -> Int { self.size }

pub fn MlclusteropticsPath::get(self : MlclusteropticsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsPath::set(self : MlclusteropticsPath, i : Int, v : Double) -> MlclusteropticsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsPath::sum(self : MlclusteropticsPath) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsPath::mean(self : MlclusteropticsPath) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsPath::scale(self : MlclusteropticsPath, f : Double) -> MlclusteropticsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsPath::add(self : MlclusteropticsPath, other : MlclusteropticsPath) -> MlclusteropticsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsPath::copy(self : MlclusteropticsPath) -> MlclusteropticsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsPath::fill(self : MlclusteropticsPath, v : Double) -> MlclusteropticsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsPath::min(self : MlclusteropticsPath) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsPath::max(self : MlclusteropticsPath) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsPath::to_string(self : MlclusteropticsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cluster_make(size : Int) -> MlclusteropticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsCluster::len(self : MlclusteropticsCluster) -> Int { self.size }

pub fn MlclusteropticsCluster::get(self : MlclusteropticsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsCluster::set(self : MlclusteropticsCluster, i : Int, v : Double) -> MlclusteropticsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCluster::sum(self : MlclusteropticsCluster) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsCluster::mean(self : MlclusteropticsCluster) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsCluster::scale(self : MlclusteropticsCluster, f : Double) -> MlclusteropticsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCluster::add(self : MlclusteropticsCluster, other : MlclusteropticsCluster) -> MlclusteropticsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsCluster::copy(self : MlclusteropticsCluster) -> MlclusteropticsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCluster::fill(self : MlclusteropticsCluster, v : Double) -> MlclusteropticsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCluster::min(self : MlclusteropticsCluster) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsCluster::max(self : MlclusteropticsCluster) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsCluster::to_string(self : MlclusteropticsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_model_make(size : Int) -> MlclusteropticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsModel::len(self : MlclusteropticsModel) -> Int { self.size }

pub fn MlclusteropticsModel::get(self : MlclusteropticsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsModel::set(self : MlclusteropticsModel, i : Int, v : Double) -> MlclusteropticsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsModel::sum(self : MlclusteropticsModel) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsModel::mean(self : MlclusteropticsModel) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsModel::scale(self : MlclusteropticsModel, f : Double) -> MlclusteropticsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsModel::add(self : MlclusteropticsModel, other : MlclusteropticsModel) -> MlclusteropticsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsModel::copy(self : MlclusteropticsModel) -> MlclusteropticsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsModel::fill(self : MlclusteropticsModel, v : Double) -> MlclusteropticsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsModel::min(self : MlclusteropticsModel) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsModel::max(self : MlclusteropticsModel) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsModel::to_string(self : MlclusteropticsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_layer_make(size : Int) -> MlclusteropticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsLayer::len(self : MlclusteropticsLayer) -> Int { self.size }

pub fn MlclusteropticsLayer::get(self : MlclusteropticsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsLayer::set(self : MlclusteropticsLayer, i : Int, v : Double) -> MlclusteropticsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsLayer::sum(self : MlclusteropticsLayer) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsLayer::mean(self : MlclusteropticsLayer) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsLayer::scale(self : MlclusteropticsLayer, f : Double) -> MlclusteropticsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsLayer::add(self : MlclusteropticsLayer, other : MlclusteropticsLayer) -> MlclusteropticsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsLayer::copy(self : MlclusteropticsLayer) -> MlclusteropticsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsLayer::fill(self : MlclusteropticsLayer, v : Double) -> MlclusteropticsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsLayer::min(self : MlclusteropticsLayer) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsLayer::max(self : MlclusteropticsLayer) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsLayer::to_string(self : MlclusteropticsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_buffer_make(size : Int) -> MlclusteropticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsBuffer::len(self : MlclusteropticsBuffer) -> Int { self.size }

pub fn MlclusteropticsBuffer::get(self : MlclusteropticsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsBuffer::set(self : MlclusteropticsBuffer, i : Int, v : Double) -> MlclusteropticsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsBuffer::sum(self : MlclusteropticsBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsBuffer::mean(self : MlclusteropticsBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsBuffer::scale(self : MlclusteropticsBuffer, f : Double) -> MlclusteropticsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsBuffer::add(self : MlclusteropticsBuffer, other : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsBuffer::copy(self : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsBuffer::fill(self : MlclusteropticsBuffer, v : Double) -> MlclusteropticsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsBuffer::min(self : MlclusteropticsBuffer) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsBuffer::max(self : MlclusteropticsBuffer) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsBuffer::to_string(self : MlclusteropticsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cursor_make(size : Int) -> MlclusteropticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsCursor::len(self : MlclusteropticsCursor) -> Int { self.size }

pub fn MlclusteropticsCursor::get(self : MlclusteropticsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsCursor::set(self : MlclusteropticsCursor, i : Int, v : Double) -> MlclusteropticsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCursor::sum(self : MlclusteropticsCursor) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsCursor::mean(self : MlclusteropticsCursor) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsCursor::scale(self : MlclusteropticsCursor, f : Double) -> MlclusteropticsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCursor::add(self : MlclusteropticsCursor, other : MlclusteropticsCursor) -> MlclusteropticsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsCursor::copy(self : MlclusteropticsCursor) -> MlclusteropticsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCursor::fill(self : MlclusteropticsCursor, v : Double) -> MlclusteropticsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsCursor::min(self : MlclusteropticsCursor) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsCursor::max(self : MlclusteropticsCursor) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsCursor::to_string(self : MlclusteropticsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_view_make(size : Int) -> MlclusteropticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsView::len(self : MlclusteropticsView) -> Int { self.size }

pub fn MlclusteropticsView::get(self : MlclusteropticsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsView::set(self : MlclusteropticsView, i : Int, v : Double) -> MlclusteropticsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsView::sum(self : MlclusteropticsView) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsView::mean(self : MlclusteropticsView) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsView::scale(self : MlclusteropticsView, f : Double) -> MlclusteropticsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsView::add(self : MlclusteropticsView, other : MlclusteropticsView) -> MlclusteropticsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsView::copy(self : MlclusteropticsView) -> MlclusteropticsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsView::fill(self : MlclusteropticsView, v : Double) -> MlclusteropticsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsView::min(self : MlclusteropticsView) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsView::max(self : MlclusteropticsView) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsView::to_string(self : MlclusteropticsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_range_make(size : Int) -> MlclusteropticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsRange::len(self : MlclusteropticsRange) -> Int { self.size }

pub fn MlclusteropticsRange::get(self : MlclusteropticsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsRange::set(self : MlclusteropticsRange, i : Int, v : Double) -> MlclusteropticsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsRange::sum(self : MlclusteropticsRange) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsRange::mean(self : MlclusteropticsRange) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsRange::scale(self : MlclusteropticsRange, f : Double) -> MlclusteropticsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsRange::add(self : MlclusteropticsRange, other : MlclusteropticsRange) -> MlclusteropticsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsRange::copy(self : MlclusteropticsRange) -> MlclusteropticsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsRange::fill(self : MlclusteropticsRange, v : Double) -> MlclusteropticsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsRange::min(self : MlclusteropticsRange) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsRange::max(self : MlclusteropticsRange) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsRange::to_string(self : MlclusteropticsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_slice_make(size : Int) -> MlclusteropticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusteropticsSlice::len(self : MlclusteropticsSlice) -> Int { self.size }

pub fn MlclusteropticsSlice::get(self : MlclusteropticsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusteropticsSlice::set(self : MlclusteropticsSlice, i : Int, v : Double) -> MlclusteropticsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusteropticsSlice::sum(self : MlclusteropticsSlice) -> Double { @_common.sum(self.data) }

pub fn MlclusteropticsSlice::mean(self : MlclusteropticsSlice) -> Double { @_common.mean(self.data) }

pub fn MlclusteropticsSlice::scale(self : MlclusteropticsSlice, f : Double) -> MlclusteropticsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsSlice::add(self : MlclusteropticsSlice, other : MlclusteropticsSlice) -> MlclusteropticsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusteropticsSlice::copy(self : MlclusteropticsSlice) -> MlclusteropticsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsSlice::fill(self : MlclusteropticsSlice, v : Double) -> MlclusteropticsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusteropticsSlice::min(self : MlclusteropticsSlice) -> Double { @_common.min(self.data) }

pub fn MlclusteropticsSlice::max(self : MlclusteropticsSlice) -> Double { @_common.max(self.data) }

pub fn MlclusteropticsSlice::to_string(self : MlclusteropticsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

