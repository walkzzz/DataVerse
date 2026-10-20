///===
/// extcore/chem_mol_props_logp

pub(all) struct ChemmolpropslogpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_logp_make_point(x : Double, y : Double) -> ChemmolpropslogpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_logp_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropslogpPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropslogpPoint::x(self : ChemmolpropslogpPoint) -> Double { self.x }

pub fn ChemmolpropslogpPoint::y(self : ChemmolpropslogpPoint) -> Double { self.y }

pub fn ChemmolpropslogpPoint::z(self : ChemmolpropslogpPoint) -> Double { self.z }

pub fn ChemmolpropslogpPoint::label(self : ChemmolpropslogpPoint) -> Int { self.label }

pub fn ChemmolpropslogpPoint::dist(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropslogpPoint::add(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::sub(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::scale(self : ChemmolpropslogpPoint, s : Double) -> ChemmolpropslogpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropslogpPoint::dot(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropslogpPoint::cross(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropslogpPoint::norm(self : ChemmolpropslogpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropslogpPoint::normalize(self : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropslogpPoint::negate(self : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::mid(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropslogpPoint::lerp(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint, t : Double) -> ChemmolpropslogpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropslogpPoint::to_string(self : ChemmolpropslogpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_logp_make_series(vals : Array[Double], name : String) -> ChemmolpropslogpSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropslogpSeries::len(self : ChemmolpropslogpSeries) -> Int { self.vals.length() }

pub fn ChemmolpropslogpSeries::sum(self : ChemmolpropslogpSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropslogpSeries::mean(self : ChemmolpropslogpSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropslogpSeries::min(self : ChemmolpropslogpSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropslogpSeries::max(self : ChemmolpropslogpSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropslogpSeries::range(self : ChemmolpropslogpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropslogpSeries::variance(self : ChemmolpropslogpSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropslogpSeries::std(self : ChemmolpropslogpSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropslogpSeries::median(self : ChemmolpropslogpSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropslogpSeries::scale(self : ChemmolpropslogpSeries, f : Double) -> ChemmolpropslogpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::add(self : ChemmolpropslogpSeries, other : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::sub(self : ChemmolpropslogpSeries, other : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::normalize(self : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropslogpSeries::cumsum(self : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropslogpSeries::to_string(self : ChemmolpropslogpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropslogpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_logp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropslogpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_logp_matrix_identity(n : Int) -> ChemmolpropslogpMatrix {
  let m = chem_mol_props_logp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropslogpMatrix::get(self : ChemmolpropslogpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropslogpMatrix::transpose(self : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropslogpMatrix::add(self : ChemmolpropslogpMatrix, other : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_logp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropslogpMatrix::scale(self : ChemmolpropslogpMatrix, s : Double) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropslogpMatrix::multiply(self : ChemmolpropslogpMatrix, other : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if self.cols != other.rows { return chem_mol_props_logp_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_logp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolpropslogpMatrix::trace(self : ChemmolpropslogpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropslogpMatrix::det(self : ChemmolpropslogpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropslogpMatrix::norm(self : ChemmolpropslogpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropslogpMatrix::to_string(self : ChemmolpropslogpMatrix) -> String {
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

pub(all) struct ChemmolpropslogpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_logp_make_vector(comps : Array[Double]) -> ChemmolpropslogpVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_logp_vector_zero(dim : Int) -> ChemmolpropslogpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropslogpVector::add(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropslogpVector::sub(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropslogpVector::scale(self : ChemmolpropslogpVector, s : Double) -> ChemmolpropslogpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropslogpVector::dot(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropslogpVector::norm(self : ChemmolpropslogpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropslogpVector::normalize(self : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropslogpVector::dist(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropslogpVector::to_string(self : ChemmolpropslogpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropslogpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_frame_make(size : Int) -> ChemmolpropslogpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpFrame::len(self : ChemmolpropslogpFrame) -> Int { self.size }

pub fn ChemmolpropslogpFrame::get(self : ChemmolpropslogpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpFrame::set(self : ChemmolpropslogpFrame, i : Int, v : Double) -> ChemmolpropslogpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpFrame::sum(self : ChemmolpropslogpFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpFrame::mean(self : ChemmolpropslogpFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpFrame::scale(self : ChemmolpropslogpFrame, f : Double) -> ChemmolpropslogpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpFrame::add(self : ChemmolpropslogpFrame, other : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpFrame::copy(self : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpFrame::fill(self : ChemmolpropslogpFrame, v : Double) -> ChemmolpropslogpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpFrame::min(self : ChemmolpropslogpFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpFrame::max(self : ChemmolpropslogpFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpFrame::to_string(self : ChemmolpropslogpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_table_make(size : Int) -> ChemmolpropslogpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpTable::len(self : ChemmolpropslogpTable) -> Int { self.size }

pub fn ChemmolpropslogpTable::get(self : ChemmolpropslogpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpTable::set(self : ChemmolpropslogpTable, i : Int, v : Double) -> ChemmolpropslogpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpTable::sum(self : ChemmolpropslogpTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpTable::mean(self : ChemmolpropslogpTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpTable::scale(self : ChemmolpropslogpTable, f : Double) -> ChemmolpropslogpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpTable::add(self : ChemmolpropslogpTable, other : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpTable::copy(self : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpTable::fill(self : ChemmolpropslogpTable, v : Double) -> ChemmolpropslogpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpTable::min(self : ChemmolpropslogpTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpTable::max(self : ChemmolpropslogpTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpTable::to_string(self : ChemmolpropslogpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_graphn_make(size : Int) -> ChemmolpropslogpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpGraphN::len(self : ChemmolpropslogpGraphN) -> Int { self.size }

pub fn ChemmolpropslogpGraphN::get(self : ChemmolpropslogpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpGraphN::set(self : ChemmolpropslogpGraphN, i : Int, v : Double) -> ChemmolpropslogpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpGraphN::sum(self : ChemmolpropslogpGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpGraphN::mean(self : ChemmolpropslogpGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpGraphN::scale(self : ChemmolpropslogpGraphN, f : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpGraphN::add(self : ChemmolpropslogpGraphN, other : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpGraphN::copy(self : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpGraphN::fill(self : ChemmolpropslogpGraphN, v : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpGraphN::min(self : ChemmolpropslogpGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpGraphN::max(self : ChemmolpropslogpGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpGraphN::to_string(self : ChemmolpropslogpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_node_make(size : Int) -> ChemmolpropslogpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpNode::len(self : ChemmolpropslogpNode) -> Int { self.size }

pub fn ChemmolpropslogpNode::get(self : ChemmolpropslogpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpNode::set(self : ChemmolpropslogpNode, i : Int, v : Double) -> ChemmolpropslogpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpNode::sum(self : ChemmolpropslogpNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpNode::mean(self : ChemmolpropslogpNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpNode::scale(self : ChemmolpropslogpNode, f : Double) -> ChemmolpropslogpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpNode::add(self : ChemmolpropslogpNode, other : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpNode::copy(self : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpNode::fill(self : ChemmolpropslogpNode, v : Double) -> ChemmolpropslogpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpNode::min(self : ChemmolpropslogpNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpNode::max(self : ChemmolpropslogpNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpNode::to_string(self : ChemmolpropslogpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_edge_make(size : Int) -> ChemmolpropslogpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpEdge::len(self : ChemmolpropslogpEdge) -> Int { self.size }

pub fn ChemmolpropslogpEdge::get(self : ChemmolpropslogpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpEdge::set(self : ChemmolpropslogpEdge, i : Int, v : Double) -> ChemmolpropslogpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpEdge::sum(self : ChemmolpropslogpEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpEdge::mean(self : ChemmolpropslogpEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpEdge::scale(self : ChemmolpropslogpEdge, f : Double) -> ChemmolpropslogpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpEdge::add(self : ChemmolpropslogpEdge, other : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpEdge::copy(self : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpEdge::fill(self : ChemmolpropslogpEdge, v : Double) -> ChemmolpropslogpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpEdge::min(self : ChemmolpropslogpEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpEdge::max(self : ChemmolpropslogpEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpEdge::to_string(self : ChemmolpropslogpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_path_make(size : Int) -> ChemmolpropslogpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpPath::len(self : ChemmolpropslogpPath) -> Int { self.size }

pub fn ChemmolpropslogpPath::get(self : ChemmolpropslogpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpPath::set(self : ChemmolpropslogpPath, i : Int, v : Double) -> ChemmolpropslogpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpPath::sum(self : ChemmolpropslogpPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpPath::mean(self : ChemmolpropslogpPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpPath::scale(self : ChemmolpropslogpPath, f : Double) -> ChemmolpropslogpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpPath::add(self : ChemmolpropslogpPath, other : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpPath::copy(self : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpPath::fill(self : ChemmolpropslogpPath, v : Double) -> ChemmolpropslogpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpPath::min(self : ChemmolpropslogpPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpPath::max(self : ChemmolpropslogpPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpPath::to_string(self : ChemmolpropslogpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cluster_make(size : Int) -> ChemmolpropslogpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpCluster::len(self : ChemmolpropslogpCluster) -> Int { self.size }

pub fn ChemmolpropslogpCluster::get(self : ChemmolpropslogpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpCluster::set(self : ChemmolpropslogpCluster, i : Int, v : Double) -> ChemmolpropslogpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCluster::sum(self : ChemmolpropslogpCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpCluster::mean(self : ChemmolpropslogpCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpCluster::scale(self : ChemmolpropslogpCluster, f : Double) -> ChemmolpropslogpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCluster::add(self : ChemmolpropslogpCluster, other : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpCluster::copy(self : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCluster::fill(self : ChemmolpropslogpCluster, v : Double) -> ChemmolpropslogpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCluster::min(self : ChemmolpropslogpCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpCluster::max(self : ChemmolpropslogpCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpCluster::to_string(self : ChemmolpropslogpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_model_make(size : Int) -> ChemmolpropslogpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpModel::len(self : ChemmolpropslogpModel) -> Int { self.size }

pub fn ChemmolpropslogpModel::get(self : ChemmolpropslogpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpModel::set(self : ChemmolpropslogpModel, i : Int, v : Double) -> ChemmolpropslogpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpModel::sum(self : ChemmolpropslogpModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpModel::mean(self : ChemmolpropslogpModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpModel::scale(self : ChemmolpropslogpModel, f : Double) -> ChemmolpropslogpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpModel::add(self : ChemmolpropslogpModel, other : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpModel::copy(self : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpModel::fill(self : ChemmolpropslogpModel, v : Double) -> ChemmolpropslogpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpModel::min(self : ChemmolpropslogpModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpModel::max(self : ChemmolpropslogpModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpModel::to_string(self : ChemmolpropslogpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_layer_make(size : Int) -> ChemmolpropslogpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpLayer::len(self : ChemmolpropslogpLayer) -> Int { self.size }

pub fn ChemmolpropslogpLayer::get(self : ChemmolpropslogpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpLayer::set(self : ChemmolpropslogpLayer, i : Int, v : Double) -> ChemmolpropslogpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpLayer::sum(self : ChemmolpropslogpLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpLayer::mean(self : ChemmolpropslogpLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpLayer::scale(self : ChemmolpropslogpLayer, f : Double) -> ChemmolpropslogpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpLayer::add(self : ChemmolpropslogpLayer, other : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpLayer::copy(self : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpLayer::fill(self : ChemmolpropslogpLayer, v : Double) -> ChemmolpropslogpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpLayer::min(self : ChemmolpropslogpLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpLayer::max(self : ChemmolpropslogpLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpLayer::to_string(self : ChemmolpropslogpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_buffer_make(size : Int) -> ChemmolpropslogpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpBuffer::len(self : ChemmolpropslogpBuffer) -> Int { self.size }

pub fn ChemmolpropslogpBuffer::get(self : ChemmolpropslogpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpBuffer::set(self : ChemmolpropslogpBuffer, i : Int, v : Double) -> ChemmolpropslogpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpBuffer::sum(self : ChemmolpropslogpBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpBuffer::mean(self : ChemmolpropslogpBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpBuffer::scale(self : ChemmolpropslogpBuffer, f : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpBuffer::add(self : ChemmolpropslogpBuffer, other : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpBuffer::copy(self : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpBuffer::fill(self : ChemmolpropslogpBuffer, v : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpBuffer::min(self : ChemmolpropslogpBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpBuffer::max(self : ChemmolpropslogpBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpBuffer::to_string(self : ChemmolpropslogpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cursor_make(size : Int) -> ChemmolpropslogpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpCursor::len(self : ChemmolpropslogpCursor) -> Int { self.size }

pub fn ChemmolpropslogpCursor::get(self : ChemmolpropslogpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpCursor::set(self : ChemmolpropslogpCursor, i : Int, v : Double) -> ChemmolpropslogpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCursor::sum(self : ChemmolpropslogpCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpCursor::mean(self : ChemmolpropslogpCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpCursor::scale(self : ChemmolpropslogpCursor, f : Double) -> ChemmolpropslogpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCursor::add(self : ChemmolpropslogpCursor, other : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpCursor::copy(self : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCursor::fill(self : ChemmolpropslogpCursor, v : Double) -> ChemmolpropslogpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpCursor::min(self : ChemmolpropslogpCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpCursor::max(self : ChemmolpropslogpCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpCursor::to_string(self : ChemmolpropslogpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_view_make(size : Int) -> ChemmolpropslogpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpView::len(self : ChemmolpropslogpView) -> Int { self.size }

pub fn ChemmolpropslogpView::get(self : ChemmolpropslogpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpView::set(self : ChemmolpropslogpView, i : Int, v : Double) -> ChemmolpropslogpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpView::sum(self : ChemmolpropslogpView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpView::mean(self : ChemmolpropslogpView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpView::scale(self : ChemmolpropslogpView, f : Double) -> ChemmolpropslogpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpView::add(self : ChemmolpropslogpView, other : ChemmolpropslogpView) -> ChemmolpropslogpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpView::copy(self : ChemmolpropslogpView) -> ChemmolpropslogpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpView::fill(self : ChemmolpropslogpView, v : Double) -> ChemmolpropslogpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpView::min(self : ChemmolpropslogpView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpView::max(self : ChemmolpropslogpView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpView::to_string(self : ChemmolpropslogpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_range_make(size : Int) -> ChemmolpropslogpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpRange::len(self : ChemmolpropslogpRange) -> Int { self.size }

pub fn ChemmolpropslogpRange::get(self : ChemmolpropslogpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpRange::set(self : ChemmolpropslogpRange, i : Int, v : Double) -> ChemmolpropslogpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpRange::sum(self : ChemmolpropslogpRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpRange::mean(self : ChemmolpropslogpRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpRange::scale(self : ChemmolpropslogpRange, f : Double) -> ChemmolpropslogpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpRange::add(self : ChemmolpropslogpRange, other : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpRange::copy(self : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpRange::fill(self : ChemmolpropslogpRange, v : Double) -> ChemmolpropslogpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpRange::min(self : ChemmolpropslogpRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpRange::max(self : ChemmolpropslogpRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpRange::to_string(self : ChemmolpropslogpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_slice_make(size : Int) -> ChemmolpropslogpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropslogpSlice::len(self : ChemmolpropslogpSlice) -> Int { self.size }

pub fn ChemmolpropslogpSlice::get(self : ChemmolpropslogpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropslogpSlice::set(self : ChemmolpropslogpSlice, i : Int, v : Double) -> ChemmolpropslogpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpSlice::sum(self : ChemmolpropslogpSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropslogpSlice::mean(self : ChemmolpropslogpSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropslogpSlice::scale(self : ChemmolpropslogpSlice, f : Double) -> ChemmolpropslogpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpSlice::add(self : ChemmolpropslogpSlice, other : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropslogpSlice::copy(self : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpSlice::fill(self : ChemmolpropslogpSlice, v : Double) -> ChemmolpropslogpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropslogpSlice::min(self : ChemmolpropslogpSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropslogpSlice::max(self : ChemmolpropslogpSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropslogpSlice::to_string(self : ChemmolpropslogpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

