///===
/// extcore/chem_desc_ecfp

pub(all) struct ChemdescecfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_ecfp_make_point(x : Double, y : Double) -> ChemdescecfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_ecfp_make_point3(x : Double, y : Double, z : Double) -> ChemdescecfpPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescecfpPoint::x(self : ChemdescecfpPoint) -> Double { self.x }

pub fn ChemdescecfpPoint::y(self : ChemdescecfpPoint) -> Double { self.y }

pub fn ChemdescecfpPoint::z(self : ChemdescecfpPoint) -> Double { self.z }

pub fn ChemdescecfpPoint::label(self : ChemdescecfpPoint) -> Int { self.label }

pub fn ChemdescecfpPoint::dist(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescecfpPoint::add(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescecfpPoint::sub(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescecfpPoint::scale(self : ChemdescecfpPoint, s : Double) -> ChemdescecfpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescecfpPoint::dot(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescecfpPoint::cross(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescecfpPoint::norm(self : ChemdescecfpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescecfpPoint::normalize(self : ChemdescecfpPoint) -> ChemdescecfpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescecfpPoint::negate(self : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescecfpPoint::mid(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescecfpPoint::lerp(self : ChemdescecfpPoint, other : ChemdescecfpPoint, t : Double) -> ChemdescecfpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescecfpPoint::to_string(self : ChemdescecfpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescecfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_ecfp_make_series(vals : Array[Double], name : String) -> ChemdescecfpSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescecfpSeries::len(self : ChemdescecfpSeries) -> Int { self.vals.length() }

pub fn ChemdescecfpSeries::sum(self : ChemdescecfpSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescecfpSeries::mean(self : ChemdescecfpSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescecfpSeries::min(self : ChemdescecfpSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescecfpSeries::max(self : ChemdescecfpSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescecfpSeries::range(self : ChemdescecfpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescecfpSeries::variance(self : ChemdescecfpSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescecfpSeries::std(self : ChemdescecfpSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescecfpSeries::median(self : ChemdescecfpSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescecfpSeries::scale(self : ChemdescecfpSeries, f : Double) -> ChemdescecfpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::add(self : ChemdescecfpSeries, other : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::sub(self : ChemdescecfpSeries, other : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::normalize(self : ChemdescecfpSeries) -> ChemdescecfpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescecfpSeries::cumsum(self : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescecfpSeries::to_string(self : ChemdescecfpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescecfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_ecfp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescecfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_ecfp_matrix_identity(n : Int) -> ChemdescecfpMatrix {
  let m = chem_desc_ecfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescecfpMatrix::get(self : ChemdescecfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescecfpMatrix::transpose(self : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescecfpMatrix::add(self : ChemdescecfpMatrix, other : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_ecfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescecfpMatrix::scale(self : ChemdescecfpMatrix, s : Double) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescecfpMatrix::multiply(self : ChemdescecfpMatrix, other : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if self.cols != other.rows { return chem_desc_ecfp_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_ecfp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescecfpMatrix::trace(self : ChemdescecfpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescecfpMatrix::det(self : ChemdescecfpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescecfpMatrix::norm(self : ChemdescecfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescecfpMatrix::to_string(self : ChemdescecfpMatrix) -> String {
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

pub(all) struct ChemdescecfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_ecfp_make_vector(comps : Array[Double]) -> ChemdescecfpVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_ecfp_vector_zero(dim : Int) -> ChemdescecfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescecfpVector::add(self : ChemdescecfpVector, other : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescecfpVector::sub(self : ChemdescecfpVector, other : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescecfpVector::scale(self : ChemdescecfpVector, s : Double) -> ChemdescecfpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescecfpVector::dot(self : ChemdescecfpVector, other : ChemdescecfpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescecfpVector::norm(self : ChemdescecfpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescecfpVector::normalize(self : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescecfpVector::dist(self : ChemdescecfpVector, other : ChemdescecfpVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescecfpVector::to_string(self : ChemdescecfpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescecfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_frame_make(size : Int) -> ChemdescecfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpFrame::len(self : ChemdescecfpFrame) -> Int { self.size }

pub fn ChemdescecfpFrame::get(self : ChemdescecfpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpFrame::set(self : ChemdescecfpFrame, i : Int, v : Double) -> ChemdescecfpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpFrame::sum(self : ChemdescecfpFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpFrame::mean(self : ChemdescecfpFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpFrame::scale(self : ChemdescecfpFrame, f : Double) -> ChemdescecfpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpFrame::add(self : ChemdescecfpFrame, other : ChemdescecfpFrame) -> ChemdescecfpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpFrame::copy(self : ChemdescecfpFrame) -> ChemdescecfpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpFrame::fill(self : ChemdescecfpFrame, v : Double) -> ChemdescecfpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpFrame::min(self : ChemdescecfpFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpFrame::max(self : ChemdescecfpFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpFrame::to_string(self : ChemdescecfpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_table_make(size : Int) -> ChemdescecfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpTable::len(self : ChemdescecfpTable) -> Int { self.size }

pub fn ChemdescecfpTable::get(self : ChemdescecfpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpTable::set(self : ChemdescecfpTable, i : Int, v : Double) -> ChemdescecfpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpTable::sum(self : ChemdescecfpTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpTable::mean(self : ChemdescecfpTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpTable::scale(self : ChemdescecfpTable, f : Double) -> ChemdescecfpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpTable::add(self : ChemdescecfpTable, other : ChemdescecfpTable) -> ChemdescecfpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpTable::copy(self : ChemdescecfpTable) -> ChemdescecfpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpTable::fill(self : ChemdescecfpTable, v : Double) -> ChemdescecfpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpTable::min(self : ChemdescecfpTable) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpTable::max(self : ChemdescecfpTable) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpTable::to_string(self : ChemdescecfpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_graphn_make(size : Int) -> ChemdescecfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpGraphN::len(self : ChemdescecfpGraphN) -> Int { self.size }

pub fn ChemdescecfpGraphN::get(self : ChemdescecfpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpGraphN::set(self : ChemdescecfpGraphN, i : Int, v : Double) -> ChemdescecfpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpGraphN::sum(self : ChemdescecfpGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpGraphN::mean(self : ChemdescecfpGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpGraphN::scale(self : ChemdescecfpGraphN, f : Double) -> ChemdescecfpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpGraphN::add(self : ChemdescecfpGraphN, other : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpGraphN::copy(self : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpGraphN::fill(self : ChemdescecfpGraphN, v : Double) -> ChemdescecfpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpGraphN::min(self : ChemdescecfpGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpGraphN::max(self : ChemdescecfpGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpGraphN::to_string(self : ChemdescecfpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_node_make(size : Int) -> ChemdescecfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpNode::len(self : ChemdescecfpNode) -> Int { self.size }

pub fn ChemdescecfpNode::get(self : ChemdescecfpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpNode::set(self : ChemdescecfpNode, i : Int, v : Double) -> ChemdescecfpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpNode::sum(self : ChemdescecfpNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpNode::mean(self : ChemdescecfpNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpNode::scale(self : ChemdescecfpNode, f : Double) -> ChemdescecfpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpNode::add(self : ChemdescecfpNode, other : ChemdescecfpNode) -> ChemdescecfpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpNode::copy(self : ChemdescecfpNode) -> ChemdescecfpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpNode::fill(self : ChemdescecfpNode, v : Double) -> ChemdescecfpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpNode::min(self : ChemdescecfpNode) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpNode::max(self : ChemdescecfpNode) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpNode::to_string(self : ChemdescecfpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_edge_make(size : Int) -> ChemdescecfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpEdge::len(self : ChemdescecfpEdge) -> Int { self.size }

pub fn ChemdescecfpEdge::get(self : ChemdescecfpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpEdge::set(self : ChemdescecfpEdge, i : Int, v : Double) -> ChemdescecfpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpEdge::sum(self : ChemdescecfpEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpEdge::mean(self : ChemdescecfpEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpEdge::scale(self : ChemdescecfpEdge, f : Double) -> ChemdescecfpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpEdge::add(self : ChemdescecfpEdge, other : ChemdescecfpEdge) -> ChemdescecfpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpEdge::copy(self : ChemdescecfpEdge) -> ChemdescecfpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpEdge::fill(self : ChemdescecfpEdge, v : Double) -> ChemdescecfpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpEdge::min(self : ChemdescecfpEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpEdge::max(self : ChemdescecfpEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpEdge::to_string(self : ChemdescecfpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_path_make(size : Int) -> ChemdescecfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpPath::len(self : ChemdescecfpPath) -> Int { self.size }

pub fn ChemdescecfpPath::get(self : ChemdescecfpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpPath::set(self : ChemdescecfpPath, i : Int, v : Double) -> ChemdescecfpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpPath::sum(self : ChemdescecfpPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpPath::mean(self : ChemdescecfpPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpPath::scale(self : ChemdescecfpPath, f : Double) -> ChemdescecfpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpPath::add(self : ChemdescecfpPath, other : ChemdescecfpPath) -> ChemdescecfpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpPath::copy(self : ChemdescecfpPath) -> ChemdescecfpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpPath::fill(self : ChemdescecfpPath, v : Double) -> ChemdescecfpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpPath::min(self : ChemdescecfpPath) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpPath::max(self : ChemdescecfpPath) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpPath::to_string(self : ChemdescecfpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cluster_make(size : Int) -> ChemdescecfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpCluster::len(self : ChemdescecfpCluster) -> Int { self.size }

pub fn ChemdescecfpCluster::get(self : ChemdescecfpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpCluster::set(self : ChemdescecfpCluster, i : Int, v : Double) -> ChemdescecfpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCluster::sum(self : ChemdescecfpCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpCluster::mean(self : ChemdescecfpCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpCluster::scale(self : ChemdescecfpCluster, f : Double) -> ChemdescecfpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCluster::add(self : ChemdescecfpCluster, other : ChemdescecfpCluster) -> ChemdescecfpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpCluster::copy(self : ChemdescecfpCluster) -> ChemdescecfpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCluster::fill(self : ChemdescecfpCluster, v : Double) -> ChemdescecfpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCluster::min(self : ChemdescecfpCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpCluster::max(self : ChemdescecfpCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpCluster::to_string(self : ChemdescecfpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_model_make(size : Int) -> ChemdescecfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpModel::len(self : ChemdescecfpModel) -> Int { self.size }

pub fn ChemdescecfpModel::get(self : ChemdescecfpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpModel::set(self : ChemdescecfpModel, i : Int, v : Double) -> ChemdescecfpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpModel::sum(self : ChemdescecfpModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpModel::mean(self : ChemdescecfpModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpModel::scale(self : ChemdescecfpModel, f : Double) -> ChemdescecfpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpModel::add(self : ChemdescecfpModel, other : ChemdescecfpModel) -> ChemdescecfpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpModel::copy(self : ChemdescecfpModel) -> ChemdescecfpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpModel::fill(self : ChemdescecfpModel, v : Double) -> ChemdescecfpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpModel::min(self : ChemdescecfpModel) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpModel::max(self : ChemdescecfpModel) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpModel::to_string(self : ChemdescecfpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_layer_make(size : Int) -> ChemdescecfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpLayer::len(self : ChemdescecfpLayer) -> Int { self.size }

pub fn ChemdescecfpLayer::get(self : ChemdescecfpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpLayer::set(self : ChemdescecfpLayer, i : Int, v : Double) -> ChemdescecfpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpLayer::sum(self : ChemdescecfpLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpLayer::mean(self : ChemdescecfpLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpLayer::scale(self : ChemdescecfpLayer, f : Double) -> ChemdescecfpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpLayer::add(self : ChemdescecfpLayer, other : ChemdescecfpLayer) -> ChemdescecfpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpLayer::copy(self : ChemdescecfpLayer) -> ChemdescecfpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpLayer::fill(self : ChemdescecfpLayer, v : Double) -> ChemdescecfpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpLayer::min(self : ChemdescecfpLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpLayer::max(self : ChemdescecfpLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpLayer::to_string(self : ChemdescecfpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_buffer_make(size : Int) -> ChemdescecfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpBuffer::len(self : ChemdescecfpBuffer) -> Int { self.size }

pub fn ChemdescecfpBuffer::get(self : ChemdescecfpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpBuffer::set(self : ChemdescecfpBuffer, i : Int, v : Double) -> ChemdescecfpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpBuffer::sum(self : ChemdescecfpBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpBuffer::mean(self : ChemdescecfpBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpBuffer::scale(self : ChemdescecfpBuffer, f : Double) -> ChemdescecfpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpBuffer::add(self : ChemdescecfpBuffer, other : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpBuffer::copy(self : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpBuffer::fill(self : ChemdescecfpBuffer, v : Double) -> ChemdescecfpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpBuffer::min(self : ChemdescecfpBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpBuffer::max(self : ChemdescecfpBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpBuffer::to_string(self : ChemdescecfpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cursor_make(size : Int) -> ChemdescecfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpCursor::len(self : ChemdescecfpCursor) -> Int { self.size }

pub fn ChemdescecfpCursor::get(self : ChemdescecfpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpCursor::set(self : ChemdescecfpCursor, i : Int, v : Double) -> ChemdescecfpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCursor::sum(self : ChemdescecfpCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpCursor::mean(self : ChemdescecfpCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpCursor::scale(self : ChemdescecfpCursor, f : Double) -> ChemdescecfpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCursor::add(self : ChemdescecfpCursor, other : ChemdescecfpCursor) -> ChemdescecfpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpCursor::copy(self : ChemdescecfpCursor) -> ChemdescecfpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCursor::fill(self : ChemdescecfpCursor, v : Double) -> ChemdescecfpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpCursor::min(self : ChemdescecfpCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpCursor::max(self : ChemdescecfpCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpCursor::to_string(self : ChemdescecfpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_view_make(size : Int) -> ChemdescecfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpView::len(self : ChemdescecfpView) -> Int { self.size }

pub fn ChemdescecfpView::get(self : ChemdescecfpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpView::set(self : ChemdescecfpView, i : Int, v : Double) -> ChemdescecfpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpView::sum(self : ChemdescecfpView) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpView::mean(self : ChemdescecfpView) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpView::scale(self : ChemdescecfpView, f : Double) -> ChemdescecfpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpView::add(self : ChemdescecfpView, other : ChemdescecfpView) -> ChemdescecfpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpView::copy(self : ChemdescecfpView) -> ChemdescecfpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpView::fill(self : ChemdescecfpView, v : Double) -> ChemdescecfpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpView::min(self : ChemdescecfpView) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpView::max(self : ChemdescecfpView) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpView::to_string(self : ChemdescecfpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_range_make(size : Int) -> ChemdescecfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpRange::len(self : ChemdescecfpRange) -> Int { self.size }

pub fn ChemdescecfpRange::get(self : ChemdescecfpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpRange::set(self : ChemdescecfpRange, i : Int, v : Double) -> ChemdescecfpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpRange::sum(self : ChemdescecfpRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpRange::mean(self : ChemdescecfpRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpRange::scale(self : ChemdescecfpRange, f : Double) -> ChemdescecfpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpRange::add(self : ChemdescecfpRange, other : ChemdescecfpRange) -> ChemdescecfpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpRange::copy(self : ChemdescecfpRange) -> ChemdescecfpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpRange::fill(self : ChemdescecfpRange, v : Double) -> ChemdescecfpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpRange::min(self : ChemdescecfpRange) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpRange::max(self : ChemdescecfpRange) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpRange::to_string(self : ChemdescecfpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_slice_make(size : Int) -> ChemdescecfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescecfpSlice::len(self : ChemdescecfpSlice) -> Int { self.size }

pub fn ChemdescecfpSlice::get(self : ChemdescecfpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescecfpSlice::set(self : ChemdescecfpSlice, i : Int, v : Double) -> ChemdescecfpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescecfpSlice::sum(self : ChemdescecfpSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescecfpSlice::mean(self : ChemdescecfpSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescecfpSlice::scale(self : ChemdescecfpSlice, f : Double) -> ChemdescecfpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpSlice::add(self : ChemdescecfpSlice, other : ChemdescecfpSlice) -> ChemdescecfpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescecfpSlice::copy(self : ChemdescecfpSlice) -> ChemdescecfpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpSlice::fill(self : ChemdescecfpSlice, v : Double) -> ChemdescecfpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescecfpSlice::min(self : ChemdescecfpSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescecfpSlice::max(self : ChemdescecfpSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescecfpSlice::to_string(self : ChemdescecfpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

