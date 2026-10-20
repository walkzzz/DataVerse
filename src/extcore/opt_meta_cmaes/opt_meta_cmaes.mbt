///===
/// extcore/opt_meta_cmaes

pub(all) struct OptmetacmaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_cmaes_make_point(x : Double, y : Double) -> OptmetacmaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_cmaes_make_point3(x : Double, y : Double, z : Double) -> OptmetacmaesPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetacmaesPoint::x(self : OptmetacmaesPoint) -> Double { self.x }

pub fn OptmetacmaesPoint::y(self : OptmetacmaesPoint) -> Double { self.y }

pub fn OptmetacmaesPoint::z(self : OptmetacmaesPoint) -> Double { self.z }

pub fn OptmetacmaesPoint::label(self : OptmetacmaesPoint) -> Int { self.label }

pub fn OptmetacmaesPoint::dist(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetacmaesPoint::add(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetacmaesPoint::sub(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetacmaesPoint::scale(self : OptmetacmaesPoint, s : Double) -> OptmetacmaesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetacmaesPoint::dot(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetacmaesPoint::cross(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetacmaesPoint::norm(self : OptmetacmaesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetacmaesPoint::normalize(self : OptmetacmaesPoint) -> OptmetacmaesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetacmaesPoint::negate(self : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetacmaesPoint::mid(self : OptmetacmaesPoint, other : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetacmaesPoint::lerp(self : OptmetacmaesPoint, other : OptmetacmaesPoint, t : Double) -> OptmetacmaesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetacmaesPoint::to_string(self : OptmetacmaesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetacmaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_cmaes_make_series(vals : Array[Double], name : String) -> OptmetacmaesSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetacmaesSeries::len(self : OptmetacmaesSeries) -> Int { self.vals.length() }

pub fn OptmetacmaesSeries::sum(self : OptmetacmaesSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetacmaesSeries::mean(self : OptmetacmaesSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetacmaesSeries::min(self : OptmetacmaesSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetacmaesSeries::max(self : OptmetacmaesSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetacmaesSeries::range(self : OptmetacmaesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetacmaesSeries::variance(self : OptmetacmaesSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetacmaesSeries::std(self : OptmetacmaesSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetacmaesSeries::median(self : OptmetacmaesSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetacmaesSeries::scale(self : OptmetacmaesSeries, f : Double) -> OptmetacmaesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::add(self : OptmetacmaesSeries, other : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::sub(self : OptmetacmaesSeries, other : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetacmaesSeries::normalize(self : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetacmaesSeries::cumsum(self : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetacmaesSeries::to_string(self : OptmetacmaesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetacmaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_cmaes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetacmaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_cmaes_matrix_identity(n : Int) -> OptmetacmaesMatrix {
  let m = opt_meta_cmaes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetacmaesMatrix::get(self : OptmetacmaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetacmaesMatrix::transpose(self : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetacmaesMatrix::add(self : OptmetacmaesMatrix, other : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_cmaes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetacmaesMatrix::scale(self : OptmetacmaesMatrix, s : Double) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetacmaesMatrix::multiply(self : OptmetacmaesMatrix, other : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if self.cols != other.rows { return opt_meta_cmaes_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_cmaes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetacmaesMatrix::trace(self : OptmetacmaesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetacmaesMatrix::det(self : OptmetacmaesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetacmaesMatrix::norm(self : OptmetacmaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetacmaesMatrix::to_string(self : OptmetacmaesMatrix) -> String {
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

pub(all) struct OptmetacmaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_cmaes_make_vector(comps : Array[Double]) -> OptmetacmaesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_cmaes_vector_zero(dim : Int) -> OptmetacmaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetacmaesVector::add(self : OptmetacmaesVector, other : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetacmaesVector::sub(self : OptmetacmaesVector, other : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetacmaesVector::scale(self : OptmetacmaesVector, s : Double) -> OptmetacmaesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetacmaesVector::dot(self : OptmetacmaesVector, other : OptmetacmaesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetacmaesVector::norm(self : OptmetacmaesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetacmaesVector::normalize(self : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetacmaesVector::dist(self : OptmetacmaesVector, other : OptmetacmaesVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetacmaesVector::to_string(self : OptmetacmaesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetacmaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_frame_make(size : Int) -> OptmetacmaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesFrame::len(self : OptmetacmaesFrame) -> Int { self.size }

pub fn OptmetacmaesFrame::get(self : OptmetacmaesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesFrame::set(self : OptmetacmaesFrame, i : Int, v : Double) -> OptmetacmaesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesFrame::sum(self : OptmetacmaesFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesFrame::mean(self : OptmetacmaesFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesFrame::scale(self : OptmetacmaesFrame, f : Double) -> OptmetacmaesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesFrame::add(self : OptmetacmaesFrame, other : OptmetacmaesFrame) -> OptmetacmaesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesFrame::copy(self : OptmetacmaesFrame) -> OptmetacmaesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesFrame::fill(self : OptmetacmaesFrame, v : Double) -> OptmetacmaesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesFrame::min(self : OptmetacmaesFrame) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesFrame::max(self : OptmetacmaesFrame) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesFrame::to_string(self : OptmetacmaesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_table_make(size : Int) -> OptmetacmaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesTable::len(self : OptmetacmaesTable) -> Int { self.size }

pub fn OptmetacmaesTable::get(self : OptmetacmaesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesTable::set(self : OptmetacmaesTable, i : Int, v : Double) -> OptmetacmaesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesTable::sum(self : OptmetacmaesTable) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesTable::mean(self : OptmetacmaesTable) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesTable::scale(self : OptmetacmaesTable, f : Double) -> OptmetacmaesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesTable::add(self : OptmetacmaesTable, other : OptmetacmaesTable) -> OptmetacmaesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesTable::copy(self : OptmetacmaesTable) -> OptmetacmaesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesTable::fill(self : OptmetacmaesTable, v : Double) -> OptmetacmaesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesTable::min(self : OptmetacmaesTable) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesTable::max(self : OptmetacmaesTable) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesTable::to_string(self : OptmetacmaesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_graphn_make(size : Int) -> OptmetacmaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesGraphN::len(self : OptmetacmaesGraphN) -> Int { self.size }

pub fn OptmetacmaesGraphN::get(self : OptmetacmaesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesGraphN::set(self : OptmetacmaesGraphN, i : Int, v : Double) -> OptmetacmaesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesGraphN::sum(self : OptmetacmaesGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesGraphN::mean(self : OptmetacmaesGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesGraphN::scale(self : OptmetacmaesGraphN, f : Double) -> OptmetacmaesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesGraphN::add(self : OptmetacmaesGraphN, other : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesGraphN::copy(self : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesGraphN::fill(self : OptmetacmaesGraphN, v : Double) -> OptmetacmaesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesGraphN::min(self : OptmetacmaesGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesGraphN::max(self : OptmetacmaesGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesGraphN::to_string(self : OptmetacmaesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_node_make(size : Int) -> OptmetacmaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesNode::len(self : OptmetacmaesNode) -> Int { self.size }

pub fn OptmetacmaesNode::get(self : OptmetacmaesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesNode::set(self : OptmetacmaesNode, i : Int, v : Double) -> OptmetacmaesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesNode::sum(self : OptmetacmaesNode) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesNode::mean(self : OptmetacmaesNode) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesNode::scale(self : OptmetacmaesNode, f : Double) -> OptmetacmaesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesNode::add(self : OptmetacmaesNode, other : OptmetacmaesNode) -> OptmetacmaesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesNode::copy(self : OptmetacmaesNode) -> OptmetacmaesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesNode::fill(self : OptmetacmaesNode, v : Double) -> OptmetacmaesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesNode::min(self : OptmetacmaesNode) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesNode::max(self : OptmetacmaesNode) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesNode::to_string(self : OptmetacmaesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_edge_make(size : Int) -> OptmetacmaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesEdge::len(self : OptmetacmaesEdge) -> Int { self.size }

pub fn OptmetacmaesEdge::get(self : OptmetacmaesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesEdge::set(self : OptmetacmaesEdge, i : Int, v : Double) -> OptmetacmaesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesEdge::sum(self : OptmetacmaesEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesEdge::mean(self : OptmetacmaesEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesEdge::scale(self : OptmetacmaesEdge, f : Double) -> OptmetacmaesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesEdge::add(self : OptmetacmaesEdge, other : OptmetacmaesEdge) -> OptmetacmaesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesEdge::copy(self : OptmetacmaesEdge) -> OptmetacmaesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesEdge::fill(self : OptmetacmaesEdge, v : Double) -> OptmetacmaesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesEdge::min(self : OptmetacmaesEdge) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesEdge::max(self : OptmetacmaesEdge) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesEdge::to_string(self : OptmetacmaesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_path_make(size : Int) -> OptmetacmaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesPath::len(self : OptmetacmaesPath) -> Int { self.size }

pub fn OptmetacmaesPath::get(self : OptmetacmaesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesPath::set(self : OptmetacmaesPath, i : Int, v : Double) -> OptmetacmaesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesPath::sum(self : OptmetacmaesPath) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesPath::mean(self : OptmetacmaesPath) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesPath::scale(self : OptmetacmaesPath, f : Double) -> OptmetacmaesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesPath::add(self : OptmetacmaesPath, other : OptmetacmaesPath) -> OptmetacmaesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesPath::copy(self : OptmetacmaesPath) -> OptmetacmaesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesPath::fill(self : OptmetacmaesPath, v : Double) -> OptmetacmaesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesPath::min(self : OptmetacmaesPath) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesPath::max(self : OptmetacmaesPath) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesPath::to_string(self : OptmetacmaesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cluster_make(size : Int) -> OptmetacmaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesCluster::len(self : OptmetacmaesCluster) -> Int { self.size }

pub fn OptmetacmaesCluster::get(self : OptmetacmaesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesCluster::set(self : OptmetacmaesCluster, i : Int, v : Double) -> OptmetacmaesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCluster::sum(self : OptmetacmaesCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesCluster::mean(self : OptmetacmaesCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesCluster::scale(self : OptmetacmaesCluster, f : Double) -> OptmetacmaesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCluster::add(self : OptmetacmaesCluster, other : OptmetacmaesCluster) -> OptmetacmaesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesCluster::copy(self : OptmetacmaesCluster) -> OptmetacmaesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCluster::fill(self : OptmetacmaesCluster, v : Double) -> OptmetacmaesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCluster::min(self : OptmetacmaesCluster) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesCluster::max(self : OptmetacmaesCluster) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesCluster::to_string(self : OptmetacmaesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_model_make(size : Int) -> OptmetacmaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesModel::len(self : OptmetacmaesModel) -> Int { self.size }

pub fn OptmetacmaesModel::get(self : OptmetacmaesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesModel::set(self : OptmetacmaesModel, i : Int, v : Double) -> OptmetacmaesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesModel::sum(self : OptmetacmaesModel) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesModel::mean(self : OptmetacmaesModel) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesModel::scale(self : OptmetacmaesModel, f : Double) -> OptmetacmaesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesModel::add(self : OptmetacmaesModel, other : OptmetacmaesModel) -> OptmetacmaesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesModel::copy(self : OptmetacmaesModel) -> OptmetacmaesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesModel::fill(self : OptmetacmaesModel, v : Double) -> OptmetacmaesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesModel::min(self : OptmetacmaesModel) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesModel::max(self : OptmetacmaesModel) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesModel::to_string(self : OptmetacmaesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_layer_make(size : Int) -> OptmetacmaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesLayer::len(self : OptmetacmaesLayer) -> Int { self.size }

pub fn OptmetacmaesLayer::get(self : OptmetacmaesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesLayer::set(self : OptmetacmaesLayer, i : Int, v : Double) -> OptmetacmaesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesLayer::sum(self : OptmetacmaesLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesLayer::mean(self : OptmetacmaesLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesLayer::scale(self : OptmetacmaesLayer, f : Double) -> OptmetacmaesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesLayer::add(self : OptmetacmaesLayer, other : OptmetacmaesLayer) -> OptmetacmaesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesLayer::copy(self : OptmetacmaesLayer) -> OptmetacmaesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesLayer::fill(self : OptmetacmaesLayer, v : Double) -> OptmetacmaesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesLayer::min(self : OptmetacmaesLayer) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesLayer::max(self : OptmetacmaesLayer) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesLayer::to_string(self : OptmetacmaesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_buffer_make(size : Int) -> OptmetacmaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesBuffer::len(self : OptmetacmaesBuffer) -> Int { self.size }

pub fn OptmetacmaesBuffer::get(self : OptmetacmaesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesBuffer::set(self : OptmetacmaesBuffer, i : Int, v : Double) -> OptmetacmaesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesBuffer::sum(self : OptmetacmaesBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesBuffer::mean(self : OptmetacmaesBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesBuffer::scale(self : OptmetacmaesBuffer, f : Double) -> OptmetacmaesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesBuffer::add(self : OptmetacmaesBuffer, other : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesBuffer::copy(self : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesBuffer::fill(self : OptmetacmaesBuffer, v : Double) -> OptmetacmaesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesBuffer::min(self : OptmetacmaesBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesBuffer::max(self : OptmetacmaesBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesBuffer::to_string(self : OptmetacmaesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cursor_make(size : Int) -> OptmetacmaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesCursor::len(self : OptmetacmaesCursor) -> Int { self.size }

pub fn OptmetacmaesCursor::get(self : OptmetacmaesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesCursor::set(self : OptmetacmaesCursor, i : Int, v : Double) -> OptmetacmaesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCursor::sum(self : OptmetacmaesCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesCursor::mean(self : OptmetacmaesCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesCursor::scale(self : OptmetacmaesCursor, f : Double) -> OptmetacmaesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCursor::add(self : OptmetacmaesCursor, other : OptmetacmaesCursor) -> OptmetacmaesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesCursor::copy(self : OptmetacmaesCursor) -> OptmetacmaesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCursor::fill(self : OptmetacmaesCursor, v : Double) -> OptmetacmaesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesCursor::min(self : OptmetacmaesCursor) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesCursor::max(self : OptmetacmaesCursor) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesCursor::to_string(self : OptmetacmaesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_view_make(size : Int) -> OptmetacmaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesView::len(self : OptmetacmaesView) -> Int { self.size }

pub fn OptmetacmaesView::get(self : OptmetacmaesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesView::set(self : OptmetacmaesView, i : Int, v : Double) -> OptmetacmaesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesView::sum(self : OptmetacmaesView) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesView::mean(self : OptmetacmaesView) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesView::scale(self : OptmetacmaesView, f : Double) -> OptmetacmaesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesView::add(self : OptmetacmaesView, other : OptmetacmaesView) -> OptmetacmaesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesView::copy(self : OptmetacmaesView) -> OptmetacmaesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesView::fill(self : OptmetacmaesView, v : Double) -> OptmetacmaesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesView::min(self : OptmetacmaesView) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesView::max(self : OptmetacmaesView) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesView::to_string(self : OptmetacmaesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_range_make(size : Int) -> OptmetacmaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesRange::len(self : OptmetacmaesRange) -> Int { self.size }

pub fn OptmetacmaesRange::get(self : OptmetacmaesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesRange::set(self : OptmetacmaesRange, i : Int, v : Double) -> OptmetacmaesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesRange::sum(self : OptmetacmaesRange) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesRange::mean(self : OptmetacmaesRange) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesRange::scale(self : OptmetacmaesRange, f : Double) -> OptmetacmaesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesRange::add(self : OptmetacmaesRange, other : OptmetacmaesRange) -> OptmetacmaesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesRange::copy(self : OptmetacmaesRange) -> OptmetacmaesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesRange::fill(self : OptmetacmaesRange, v : Double) -> OptmetacmaesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesRange::min(self : OptmetacmaesRange) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesRange::max(self : OptmetacmaesRange) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesRange::to_string(self : OptmetacmaesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_slice_make(size : Int) -> OptmetacmaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetacmaesSlice::len(self : OptmetacmaesSlice) -> Int { self.size }

pub fn OptmetacmaesSlice::get(self : OptmetacmaesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetacmaesSlice::set(self : OptmetacmaesSlice, i : Int, v : Double) -> OptmetacmaesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetacmaesSlice::sum(self : OptmetacmaesSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetacmaesSlice::mean(self : OptmetacmaesSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetacmaesSlice::scale(self : OptmetacmaesSlice, f : Double) -> OptmetacmaesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesSlice::add(self : OptmetacmaesSlice, other : OptmetacmaesSlice) -> OptmetacmaesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetacmaesSlice::copy(self : OptmetacmaesSlice) -> OptmetacmaesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesSlice::fill(self : OptmetacmaesSlice, v : Double) -> OptmetacmaesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetacmaesSlice::min(self : OptmetacmaesSlice) -> Double { @_common.min(self.data) }

pub fn OptmetacmaesSlice::max(self : OptmetacmaesSlice) -> Double { @_common.max(self.data) }

pub fn OptmetacmaesSlice::to_string(self : OptmetacmaesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

