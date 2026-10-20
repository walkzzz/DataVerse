///===
/// extcore/opt_grad_amsgrad

pub(all) struct OptgradamsgradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_amsgrad_make_point(x : Double, y : Double) -> OptgradamsgradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_amsgrad_make_point3(x : Double, y : Double, z : Double) -> OptgradamsgradPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradamsgradPoint::x(self : OptgradamsgradPoint) -> Double { self.x }

pub fn OptgradamsgradPoint::y(self : OptgradamsgradPoint) -> Double { self.y }

pub fn OptgradamsgradPoint::z(self : OptgradamsgradPoint) -> Double { self.z }

pub fn OptgradamsgradPoint::label(self : OptgradamsgradPoint) -> Int { self.label }

pub fn OptgradamsgradPoint::dist(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradamsgradPoint::add(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradamsgradPoint::sub(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradamsgradPoint::scale(self : OptgradamsgradPoint, s : Double) -> OptgradamsgradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradamsgradPoint::dot(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradamsgradPoint::cross(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradamsgradPoint::norm(self : OptgradamsgradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradamsgradPoint::normalize(self : OptgradamsgradPoint) -> OptgradamsgradPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradamsgradPoint::negate(self : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradamsgradPoint::mid(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradamsgradPoint::lerp(self : OptgradamsgradPoint, other : OptgradamsgradPoint, t : Double) -> OptgradamsgradPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradamsgradPoint::to_string(self : OptgradamsgradPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradamsgradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_amsgrad_make_series(vals : Array[Double], name : String) -> OptgradamsgradSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradamsgradSeries::len(self : OptgradamsgradSeries) -> Int { self.vals.length() }

pub fn OptgradamsgradSeries::sum(self : OptgradamsgradSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradamsgradSeries::mean(self : OptgradamsgradSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradamsgradSeries::min(self : OptgradamsgradSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradamsgradSeries::max(self : OptgradamsgradSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradamsgradSeries::range(self : OptgradamsgradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradamsgradSeries::variance(self : OptgradamsgradSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradamsgradSeries::std(self : OptgradamsgradSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradamsgradSeries::median(self : OptgradamsgradSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradamsgradSeries::scale(self : OptgradamsgradSeries, f : Double) -> OptgradamsgradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::add(self : OptgradamsgradSeries, other : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::sub(self : OptgradamsgradSeries, other : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::normalize(self : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradamsgradSeries::cumsum(self : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradamsgradSeries::to_string(self : OptgradamsgradSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradamsgradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_amsgrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradamsgradMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn opt_grad_amsgrad_matrix_identity(n : Int) -> OptgradamsgradMatrix {
  let m = opt_grad_amsgrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradamsgradMatrix::get(self : OptgradamsgradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradamsgradMatrix::transpose(self : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradamsgradMatrix::add(self : OptgradamsgradMatrix, other : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_amsgrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradamsgradMatrix::scale(self : OptgradamsgradMatrix, s : Double) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradamsgradMatrix::multiply(self : OptgradamsgradMatrix, other : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if self.cols != other.rows { return opt_grad_amsgrad_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_amsgrad_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptgradamsgradMatrix::trace(self : OptgradamsgradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradamsgradMatrix::det(self : OptgradamsgradMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradamsgradMatrix::norm(self : OptgradamsgradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradamsgradMatrix::to_string(self : OptgradamsgradMatrix) -> String {
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

pub(all) struct OptgradamsgradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_amsgrad_make_vector(comps : Array[Double]) -> OptgradamsgradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_amsgrad_vector_zero(dim : Int) -> OptgradamsgradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradamsgradVector::add(self : OptgradamsgradVector, other : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradamsgradVector::sub(self : OptgradamsgradVector, other : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradamsgradVector::scale(self : OptgradamsgradVector, s : Double) -> OptgradamsgradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradamsgradVector::dot(self : OptgradamsgradVector, other : OptgradamsgradVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradamsgradVector::norm(self : OptgradamsgradVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradamsgradVector::normalize(self : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradamsgradVector::dist(self : OptgradamsgradVector, other : OptgradamsgradVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradamsgradVector::to_string(self : OptgradamsgradVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradamsgradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_frame_make(size : Int) -> OptgradamsgradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradFrame::len(self : OptgradamsgradFrame) -> Int { self.size }

pub fn OptgradamsgradFrame::get(self : OptgradamsgradFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradFrame::set(self : OptgradamsgradFrame, i : Int, v : Double) -> OptgradamsgradFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradFrame::sum(self : OptgradamsgradFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradFrame::mean(self : OptgradamsgradFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradFrame::scale(self : OptgradamsgradFrame, f : Double) -> OptgradamsgradFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradFrame::add(self : OptgradamsgradFrame, other : OptgradamsgradFrame) -> OptgradamsgradFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradFrame::copy(self : OptgradamsgradFrame) -> OptgradamsgradFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradFrame::fill(self : OptgradamsgradFrame, v : Double) -> OptgradamsgradFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradFrame::min(self : OptgradamsgradFrame) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradFrame::max(self : OptgradamsgradFrame) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradFrame::to_string(self : OptgradamsgradFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_table_make(size : Int) -> OptgradamsgradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradTable::len(self : OptgradamsgradTable) -> Int { self.size }

pub fn OptgradamsgradTable::get(self : OptgradamsgradTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradTable::set(self : OptgradamsgradTable, i : Int, v : Double) -> OptgradamsgradTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradTable::sum(self : OptgradamsgradTable) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradTable::mean(self : OptgradamsgradTable) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradTable::scale(self : OptgradamsgradTable, f : Double) -> OptgradamsgradTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradTable::add(self : OptgradamsgradTable, other : OptgradamsgradTable) -> OptgradamsgradTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradTable::copy(self : OptgradamsgradTable) -> OptgradamsgradTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradTable::fill(self : OptgradamsgradTable, v : Double) -> OptgradamsgradTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradTable::min(self : OptgradamsgradTable) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradTable::max(self : OptgradamsgradTable) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradTable::to_string(self : OptgradamsgradTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_graphn_make(size : Int) -> OptgradamsgradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradGraphN::len(self : OptgradamsgradGraphN) -> Int { self.size }

pub fn OptgradamsgradGraphN::get(self : OptgradamsgradGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradGraphN::set(self : OptgradamsgradGraphN, i : Int, v : Double) -> OptgradamsgradGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradGraphN::sum(self : OptgradamsgradGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradGraphN::mean(self : OptgradamsgradGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradGraphN::scale(self : OptgradamsgradGraphN, f : Double) -> OptgradamsgradGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradGraphN::add(self : OptgradamsgradGraphN, other : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradGraphN::copy(self : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradGraphN::fill(self : OptgradamsgradGraphN, v : Double) -> OptgradamsgradGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradGraphN::min(self : OptgradamsgradGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradGraphN::max(self : OptgradamsgradGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradGraphN::to_string(self : OptgradamsgradGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_node_make(size : Int) -> OptgradamsgradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradNode::len(self : OptgradamsgradNode) -> Int { self.size }

pub fn OptgradamsgradNode::get(self : OptgradamsgradNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradNode::set(self : OptgradamsgradNode, i : Int, v : Double) -> OptgradamsgradNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradNode::sum(self : OptgradamsgradNode) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradNode::mean(self : OptgradamsgradNode) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradNode::scale(self : OptgradamsgradNode, f : Double) -> OptgradamsgradNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradNode::add(self : OptgradamsgradNode, other : OptgradamsgradNode) -> OptgradamsgradNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradNode::copy(self : OptgradamsgradNode) -> OptgradamsgradNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradNode::fill(self : OptgradamsgradNode, v : Double) -> OptgradamsgradNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradNode::min(self : OptgradamsgradNode) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradNode::max(self : OptgradamsgradNode) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradNode::to_string(self : OptgradamsgradNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_edge_make(size : Int) -> OptgradamsgradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradEdge::len(self : OptgradamsgradEdge) -> Int { self.size }

pub fn OptgradamsgradEdge::get(self : OptgradamsgradEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradEdge::set(self : OptgradamsgradEdge, i : Int, v : Double) -> OptgradamsgradEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradEdge::sum(self : OptgradamsgradEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradEdge::mean(self : OptgradamsgradEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradEdge::scale(self : OptgradamsgradEdge, f : Double) -> OptgradamsgradEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradEdge::add(self : OptgradamsgradEdge, other : OptgradamsgradEdge) -> OptgradamsgradEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradEdge::copy(self : OptgradamsgradEdge) -> OptgradamsgradEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradEdge::fill(self : OptgradamsgradEdge, v : Double) -> OptgradamsgradEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradEdge::min(self : OptgradamsgradEdge) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradEdge::max(self : OptgradamsgradEdge) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradEdge::to_string(self : OptgradamsgradEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_path_make(size : Int) -> OptgradamsgradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradPath::len(self : OptgradamsgradPath) -> Int { self.size }

pub fn OptgradamsgradPath::get(self : OptgradamsgradPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradPath::set(self : OptgradamsgradPath, i : Int, v : Double) -> OptgradamsgradPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradPath::sum(self : OptgradamsgradPath) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradPath::mean(self : OptgradamsgradPath) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradPath::scale(self : OptgradamsgradPath, f : Double) -> OptgradamsgradPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradPath::add(self : OptgradamsgradPath, other : OptgradamsgradPath) -> OptgradamsgradPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradPath::copy(self : OptgradamsgradPath) -> OptgradamsgradPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradPath::fill(self : OptgradamsgradPath, v : Double) -> OptgradamsgradPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradPath::min(self : OptgradamsgradPath) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradPath::max(self : OptgradamsgradPath) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradPath::to_string(self : OptgradamsgradPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cluster_make(size : Int) -> OptgradamsgradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradCluster::len(self : OptgradamsgradCluster) -> Int { self.size }

pub fn OptgradamsgradCluster::get(self : OptgradamsgradCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradCluster::set(self : OptgradamsgradCluster, i : Int, v : Double) -> OptgradamsgradCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCluster::sum(self : OptgradamsgradCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradCluster::mean(self : OptgradamsgradCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradCluster::scale(self : OptgradamsgradCluster, f : Double) -> OptgradamsgradCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCluster::add(self : OptgradamsgradCluster, other : OptgradamsgradCluster) -> OptgradamsgradCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradCluster::copy(self : OptgradamsgradCluster) -> OptgradamsgradCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCluster::fill(self : OptgradamsgradCluster, v : Double) -> OptgradamsgradCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCluster::min(self : OptgradamsgradCluster) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradCluster::max(self : OptgradamsgradCluster) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradCluster::to_string(self : OptgradamsgradCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_model_make(size : Int) -> OptgradamsgradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradModel::len(self : OptgradamsgradModel) -> Int { self.size }

pub fn OptgradamsgradModel::get(self : OptgradamsgradModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradModel::set(self : OptgradamsgradModel, i : Int, v : Double) -> OptgradamsgradModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradModel::sum(self : OptgradamsgradModel) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradModel::mean(self : OptgradamsgradModel) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradModel::scale(self : OptgradamsgradModel, f : Double) -> OptgradamsgradModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradModel::add(self : OptgradamsgradModel, other : OptgradamsgradModel) -> OptgradamsgradModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradModel::copy(self : OptgradamsgradModel) -> OptgradamsgradModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradModel::fill(self : OptgradamsgradModel, v : Double) -> OptgradamsgradModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradModel::min(self : OptgradamsgradModel) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradModel::max(self : OptgradamsgradModel) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradModel::to_string(self : OptgradamsgradModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_layer_make(size : Int) -> OptgradamsgradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradLayer::len(self : OptgradamsgradLayer) -> Int { self.size }

pub fn OptgradamsgradLayer::get(self : OptgradamsgradLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradLayer::set(self : OptgradamsgradLayer, i : Int, v : Double) -> OptgradamsgradLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradLayer::sum(self : OptgradamsgradLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradLayer::mean(self : OptgradamsgradLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradLayer::scale(self : OptgradamsgradLayer, f : Double) -> OptgradamsgradLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradLayer::add(self : OptgradamsgradLayer, other : OptgradamsgradLayer) -> OptgradamsgradLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradLayer::copy(self : OptgradamsgradLayer) -> OptgradamsgradLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradLayer::fill(self : OptgradamsgradLayer, v : Double) -> OptgradamsgradLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradLayer::min(self : OptgradamsgradLayer) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradLayer::max(self : OptgradamsgradLayer) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradLayer::to_string(self : OptgradamsgradLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_buffer_make(size : Int) -> OptgradamsgradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradBuffer::len(self : OptgradamsgradBuffer) -> Int { self.size }

pub fn OptgradamsgradBuffer::get(self : OptgradamsgradBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradBuffer::set(self : OptgradamsgradBuffer, i : Int, v : Double) -> OptgradamsgradBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradBuffer::sum(self : OptgradamsgradBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradBuffer::mean(self : OptgradamsgradBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradBuffer::scale(self : OptgradamsgradBuffer, f : Double) -> OptgradamsgradBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradBuffer::add(self : OptgradamsgradBuffer, other : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradBuffer::copy(self : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradBuffer::fill(self : OptgradamsgradBuffer, v : Double) -> OptgradamsgradBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradBuffer::min(self : OptgradamsgradBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradBuffer::max(self : OptgradamsgradBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradBuffer::to_string(self : OptgradamsgradBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cursor_make(size : Int) -> OptgradamsgradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradCursor::len(self : OptgradamsgradCursor) -> Int { self.size }

pub fn OptgradamsgradCursor::get(self : OptgradamsgradCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradCursor::set(self : OptgradamsgradCursor, i : Int, v : Double) -> OptgradamsgradCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCursor::sum(self : OptgradamsgradCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradCursor::mean(self : OptgradamsgradCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradCursor::scale(self : OptgradamsgradCursor, f : Double) -> OptgradamsgradCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCursor::add(self : OptgradamsgradCursor, other : OptgradamsgradCursor) -> OptgradamsgradCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradCursor::copy(self : OptgradamsgradCursor) -> OptgradamsgradCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCursor::fill(self : OptgradamsgradCursor, v : Double) -> OptgradamsgradCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradCursor::min(self : OptgradamsgradCursor) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradCursor::max(self : OptgradamsgradCursor) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradCursor::to_string(self : OptgradamsgradCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_view_make(size : Int) -> OptgradamsgradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradView::len(self : OptgradamsgradView) -> Int { self.size }

pub fn OptgradamsgradView::get(self : OptgradamsgradView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradView::set(self : OptgradamsgradView, i : Int, v : Double) -> OptgradamsgradView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradView::sum(self : OptgradamsgradView) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradView::mean(self : OptgradamsgradView) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradView::scale(self : OptgradamsgradView, f : Double) -> OptgradamsgradView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradView::add(self : OptgradamsgradView, other : OptgradamsgradView) -> OptgradamsgradView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradView::copy(self : OptgradamsgradView) -> OptgradamsgradView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradView::fill(self : OptgradamsgradView, v : Double) -> OptgradamsgradView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradView::min(self : OptgradamsgradView) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradView::max(self : OptgradamsgradView) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradView::to_string(self : OptgradamsgradView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_range_make(size : Int) -> OptgradamsgradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradRange::len(self : OptgradamsgradRange) -> Int { self.size }

pub fn OptgradamsgradRange::get(self : OptgradamsgradRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradRange::set(self : OptgradamsgradRange, i : Int, v : Double) -> OptgradamsgradRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradRange::sum(self : OptgradamsgradRange) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradRange::mean(self : OptgradamsgradRange) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradRange::scale(self : OptgradamsgradRange, f : Double) -> OptgradamsgradRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradRange::add(self : OptgradamsgradRange, other : OptgradamsgradRange) -> OptgradamsgradRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradRange::copy(self : OptgradamsgradRange) -> OptgradamsgradRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradRange::fill(self : OptgradamsgradRange, v : Double) -> OptgradamsgradRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradRange::min(self : OptgradamsgradRange) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradRange::max(self : OptgradamsgradRange) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradRange::to_string(self : OptgradamsgradRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_slice_make(size : Int) -> OptgradamsgradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradamsgradSlice::len(self : OptgradamsgradSlice) -> Int { self.size }

pub fn OptgradamsgradSlice::get(self : OptgradamsgradSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradamsgradSlice::set(self : OptgradamsgradSlice, i : Int, v : Double) -> OptgradamsgradSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradamsgradSlice::sum(self : OptgradamsgradSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradamsgradSlice::mean(self : OptgradamsgradSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradamsgradSlice::scale(self : OptgradamsgradSlice, f : Double) -> OptgradamsgradSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradSlice::add(self : OptgradamsgradSlice, other : OptgradamsgradSlice) -> OptgradamsgradSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradamsgradSlice::copy(self : OptgradamsgradSlice) -> OptgradamsgradSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradSlice::fill(self : OptgradamsgradSlice, v : Double) -> OptgradamsgradSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradamsgradSlice::min(self : OptgradamsgradSlice) -> Double { @_common.min(self.data) }

pub fn OptgradamsgradSlice::max(self : OptgradamsgradSlice) -> Double { @_common.max(self.data) }

pub fn OptgradamsgradSlice::to_string(self : OptgradamsgradSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

