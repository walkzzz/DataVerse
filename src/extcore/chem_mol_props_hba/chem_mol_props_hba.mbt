///===
/// extcore/chem_mol_props_hba

pub(all) struct ChemmolpropshbaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_hba_make_point(x : Double, y : Double) -> ChemmolpropshbaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_hba_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropshbaPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropshbaPoint::x(self : ChemmolpropshbaPoint) -> Double { self.x }

pub fn ChemmolpropshbaPoint::y(self : ChemmolpropshbaPoint) -> Double { self.y }

pub fn ChemmolpropshbaPoint::z(self : ChemmolpropshbaPoint) -> Double { self.z }

pub fn ChemmolpropshbaPoint::label(self : ChemmolpropshbaPoint) -> Int { self.label }

pub fn ChemmolpropshbaPoint::dist(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropshbaPoint::add(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropshbaPoint::sub(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropshbaPoint::scale(self : ChemmolpropshbaPoint, s : Double) -> ChemmolpropshbaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropshbaPoint::dot(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropshbaPoint::cross(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropshbaPoint::norm(self : ChemmolpropshbaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropshbaPoint::normalize(self : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropshbaPoint::negate(self : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropshbaPoint::mid(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropshbaPoint::lerp(self : ChemmolpropshbaPoint, other : ChemmolpropshbaPoint, t : Double) -> ChemmolpropshbaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropshbaPoint::to_string(self : ChemmolpropshbaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_hba_make_series(vals : Array[Double], name : String) -> ChemmolpropshbaSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropshbaSeries::len(self : ChemmolpropshbaSeries) -> Int { self.vals.length() }

pub fn ChemmolpropshbaSeries::sum(self : ChemmolpropshbaSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropshbaSeries::mean(self : ChemmolpropshbaSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropshbaSeries::min(self : ChemmolpropshbaSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropshbaSeries::max(self : ChemmolpropshbaSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropshbaSeries::range(self : ChemmolpropshbaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropshbaSeries::variance(self : ChemmolpropshbaSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropshbaSeries::std(self : ChemmolpropshbaSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropshbaSeries::median(self : ChemmolpropshbaSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropshbaSeries::scale(self : ChemmolpropshbaSeries, f : Double) -> ChemmolpropshbaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropshbaSeries::add(self : ChemmolpropshbaSeries, other : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropshbaSeries::sub(self : ChemmolpropshbaSeries, other : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropshbaSeries::normalize(self : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropshbaSeries::cumsum(self : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropshbaSeries::to_string(self : ChemmolpropshbaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_hba_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropshbaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_hba_matrix_identity(n : Int) -> ChemmolpropshbaMatrix {
  let m = chem_mol_props_hba_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropshbaMatrix::get(self : ChemmolpropshbaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropshbaMatrix::transpose(self : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropshbaMatrix::add(self : ChemmolpropshbaMatrix, other : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_hba_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropshbaMatrix::scale(self : ChemmolpropshbaMatrix, s : Double) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropshbaMatrix::multiply(self : ChemmolpropshbaMatrix, other : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if self.cols != other.rows { return chem_mol_props_hba_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_hba_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolpropshbaMatrix::trace(self : ChemmolpropshbaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropshbaMatrix::det(self : ChemmolpropshbaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropshbaMatrix::norm(self : ChemmolpropshbaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropshbaMatrix::to_string(self : ChemmolpropshbaMatrix) -> String {
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

pub(all) struct ChemmolpropshbaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_hba_make_vector(comps : Array[Double]) -> ChemmolpropshbaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_hba_vector_zero(dim : Int) -> ChemmolpropshbaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropshbaVector::add(self : ChemmolpropshbaVector, other : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropshbaVector::sub(self : ChemmolpropshbaVector, other : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropshbaVector::scale(self : ChemmolpropshbaVector, s : Double) -> ChemmolpropshbaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropshbaVector::dot(self : ChemmolpropshbaVector, other : ChemmolpropshbaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropshbaVector::norm(self : ChemmolpropshbaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropshbaVector::normalize(self : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropshbaVector::dist(self : ChemmolpropshbaVector, other : ChemmolpropshbaVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropshbaVector::to_string(self : ChemmolpropshbaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_frame_make(size : Int) -> ChemmolpropshbaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaFrame::len(self : ChemmolpropshbaFrame) -> Int { self.size }

pub fn ChemmolpropshbaFrame::get(self : ChemmolpropshbaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaFrame::set(self : ChemmolpropshbaFrame, i : Int, v : Double) -> ChemmolpropshbaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaFrame::sum(self : ChemmolpropshbaFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaFrame::mean(self : ChemmolpropshbaFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaFrame::scale(self : ChemmolpropshbaFrame, f : Double) -> ChemmolpropshbaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaFrame::add(self : ChemmolpropshbaFrame, other : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaFrame::copy(self : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaFrame::fill(self : ChemmolpropshbaFrame, v : Double) -> ChemmolpropshbaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaFrame::min(self : ChemmolpropshbaFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaFrame::max(self : ChemmolpropshbaFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaFrame::to_string(self : ChemmolpropshbaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_table_make(size : Int) -> ChemmolpropshbaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaTable::len(self : ChemmolpropshbaTable) -> Int { self.size }

pub fn ChemmolpropshbaTable::get(self : ChemmolpropshbaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaTable::set(self : ChemmolpropshbaTable, i : Int, v : Double) -> ChemmolpropshbaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaTable::sum(self : ChemmolpropshbaTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaTable::mean(self : ChemmolpropshbaTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaTable::scale(self : ChemmolpropshbaTable, f : Double) -> ChemmolpropshbaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaTable::add(self : ChemmolpropshbaTable, other : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaTable::copy(self : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaTable::fill(self : ChemmolpropshbaTable, v : Double) -> ChemmolpropshbaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaTable::min(self : ChemmolpropshbaTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaTable::max(self : ChemmolpropshbaTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaTable::to_string(self : ChemmolpropshbaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_graphn_make(size : Int) -> ChemmolpropshbaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaGraphN::len(self : ChemmolpropshbaGraphN) -> Int { self.size }

pub fn ChemmolpropshbaGraphN::get(self : ChemmolpropshbaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaGraphN::set(self : ChemmolpropshbaGraphN, i : Int, v : Double) -> ChemmolpropshbaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaGraphN::sum(self : ChemmolpropshbaGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaGraphN::mean(self : ChemmolpropshbaGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaGraphN::scale(self : ChemmolpropshbaGraphN, f : Double) -> ChemmolpropshbaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaGraphN::add(self : ChemmolpropshbaGraphN, other : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaGraphN::copy(self : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaGraphN::fill(self : ChemmolpropshbaGraphN, v : Double) -> ChemmolpropshbaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaGraphN::min(self : ChemmolpropshbaGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaGraphN::max(self : ChemmolpropshbaGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaGraphN::to_string(self : ChemmolpropshbaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_node_make(size : Int) -> ChemmolpropshbaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaNode::len(self : ChemmolpropshbaNode) -> Int { self.size }

pub fn ChemmolpropshbaNode::get(self : ChemmolpropshbaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaNode::set(self : ChemmolpropshbaNode, i : Int, v : Double) -> ChemmolpropshbaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaNode::sum(self : ChemmolpropshbaNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaNode::mean(self : ChemmolpropshbaNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaNode::scale(self : ChemmolpropshbaNode, f : Double) -> ChemmolpropshbaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaNode::add(self : ChemmolpropshbaNode, other : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaNode::copy(self : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaNode::fill(self : ChemmolpropshbaNode, v : Double) -> ChemmolpropshbaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaNode::min(self : ChemmolpropshbaNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaNode::max(self : ChemmolpropshbaNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaNode::to_string(self : ChemmolpropshbaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_edge_make(size : Int) -> ChemmolpropshbaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaEdge::len(self : ChemmolpropshbaEdge) -> Int { self.size }

pub fn ChemmolpropshbaEdge::get(self : ChemmolpropshbaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaEdge::set(self : ChemmolpropshbaEdge, i : Int, v : Double) -> ChemmolpropshbaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaEdge::sum(self : ChemmolpropshbaEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaEdge::mean(self : ChemmolpropshbaEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaEdge::scale(self : ChemmolpropshbaEdge, f : Double) -> ChemmolpropshbaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaEdge::add(self : ChemmolpropshbaEdge, other : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaEdge::copy(self : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaEdge::fill(self : ChemmolpropshbaEdge, v : Double) -> ChemmolpropshbaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaEdge::min(self : ChemmolpropshbaEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaEdge::max(self : ChemmolpropshbaEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaEdge::to_string(self : ChemmolpropshbaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_path_make(size : Int) -> ChemmolpropshbaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaPath::len(self : ChemmolpropshbaPath) -> Int { self.size }

pub fn ChemmolpropshbaPath::get(self : ChemmolpropshbaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaPath::set(self : ChemmolpropshbaPath, i : Int, v : Double) -> ChemmolpropshbaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaPath::sum(self : ChemmolpropshbaPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaPath::mean(self : ChemmolpropshbaPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaPath::scale(self : ChemmolpropshbaPath, f : Double) -> ChemmolpropshbaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaPath::add(self : ChemmolpropshbaPath, other : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaPath::copy(self : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaPath::fill(self : ChemmolpropshbaPath, v : Double) -> ChemmolpropshbaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaPath::min(self : ChemmolpropshbaPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaPath::max(self : ChemmolpropshbaPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaPath::to_string(self : ChemmolpropshbaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cluster_make(size : Int) -> ChemmolpropshbaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaCluster::len(self : ChemmolpropshbaCluster) -> Int { self.size }

pub fn ChemmolpropshbaCluster::get(self : ChemmolpropshbaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaCluster::set(self : ChemmolpropshbaCluster, i : Int, v : Double) -> ChemmolpropshbaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCluster::sum(self : ChemmolpropshbaCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaCluster::mean(self : ChemmolpropshbaCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaCluster::scale(self : ChemmolpropshbaCluster, f : Double) -> ChemmolpropshbaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCluster::add(self : ChemmolpropshbaCluster, other : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaCluster::copy(self : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCluster::fill(self : ChemmolpropshbaCluster, v : Double) -> ChemmolpropshbaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCluster::min(self : ChemmolpropshbaCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaCluster::max(self : ChemmolpropshbaCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaCluster::to_string(self : ChemmolpropshbaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_model_make(size : Int) -> ChemmolpropshbaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaModel::len(self : ChemmolpropshbaModel) -> Int { self.size }

pub fn ChemmolpropshbaModel::get(self : ChemmolpropshbaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaModel::set(self : ChemmolpropshbaModel, i : Int, v : Double) -> ChemmolpropshbaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaModel::sum(self : ChemmolpropshbaModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaModel::mean(self : ChemmolpropshbaModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaModel::scale(self : ChemmolpropshbaModel, f : Double) -> ChemmolpropshbaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaModel::add(self : ChemmolpropshbaModel, other : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaModel::copy(self : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaModel::fill(self : ChemmolpropshbaModel, v : Double) -> ChemmolpropshbaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaModel::min(self : ChemmolpropshbaModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaModel::max(self : ChemmolpropshbaModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaModel::to_string(self : ChemmolpropshbaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_layer_make(size : Int) -> ChemmolpropshbaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaLayer::len(self : ChemmolpropshbaLayer) -> Int { self.size }

pub fn ChemmolpropshbaLayer::get(self : ChemmolpropshbaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaLayer::set(self : ChemmolpropshbaLayer, i : Int, v : Double) -> ChemmolpropshbaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaLayer::sum(self : ChemmolpropshbaLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaLayer::mean(self : ChemmolpropshbaLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaLayer::scale(self : ChemmolpropshbaLayer, f : Double) -> ChemmolpropshbaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaLayer::add(self : ChemmolpropshbaLayer, other : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaLayer::copy(self : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaLayer::fill(self : ChemmolpropshbaLayer, v : Double) -> ChemmolpropshbaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaLayer::min(self : ChemmolpropshbaLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaLayer::max(self : ChemmolpropshbaLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaLayer::to_string(self : ChemmolpropshbaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_buffer_make(size : Int) -> ChemmolpropshbaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaBuffer::len(self : ChemmolpropshbaBuffer) -> Int { self.size }

pub fn ChemmolpropshbaBuffer::get(self : ChemmolpropshbaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaBuffer::set(self : ChemmolpropshbaBuffer, i : Int, v : Double) -> ChemmolpropshbaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaBuffer::sum(self : ChemmolpropshbaBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaBuffer::mean(self : ChemmolpropshbaBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaBuffer::scale(self : ChemmolpropshbaBuffer, f : Double) -> ChemmolpropshbaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaBuffer::add(self : ChemmolpropshbaBuffer, other : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaBuffer::copy(self : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaBuffer::fill(self : ChemmolpropshbaBuffer, v : Double) -> ChemmolpropshbaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaBuffer::min(self : ChemmolpropshbaBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaBuffer::max(self : ChemmolpropshbaBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaBuffer::to_string(self : ChemmolpropshbaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cursor_make(size : Int) -> ChemmolpropshbaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaCursor::len(self : ChemmolpropshbaCursor) -> Int { self.size }

pub fn ChemmolpropshbaCursor::get(self : ChemmolpropshbaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaCursor::set(self : ChemmolpropshbaCursor, i : Int, v : Double) -> ChemmolpropshbaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCursor::sum(self : ChemmolpropshbaCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaCursor::mean(self : ChemmolpropshbaCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaCursor::scale(self : ChemmolpropshbaCursor, f : Double) -> ChemmolpropshbaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCursor::add(self : ChemmolpropshbaCursor, other : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaCursor::copy(self : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCursor::fill(self : ChemmolpropshbaCursor, v : Double) -> ChemmolpropshbaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaCursor::min(self : ChemmolpropshbaCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaCursor::max(self : ChemmolpropshbaCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaCursor::to_string(self : ChemmolpropshbaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_view_make(size : Int) -> ChemmolpropshbaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaView::len(self : ChemmolpropshbaView) -> Int { self.size }

pub fn ChemmolpropshbaView::get(self : ChemmolpropshbaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaView::set(self : ChemmolpropshbaView, i : Int, v : Double) -> ChemmolpropshbaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaView::sum(self : ChemmolpropshbaView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaView::mean(self : ChemmolpropshbaView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaView::scale(self : ChemmolpropshbaView, f : Double) -> ChemmolpropshbaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaView::add(self : ChemmolpropshbaView, other : ChemmolpropshbaView) -> ChemmolpropshbaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaView::copy(self : ChemmolpropshbaView) -> ChemmolpropshbaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaView::fill(self : ChemmolpropshbaView, v : Double) -> ChemmolpropshbaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaView::min(self : ChemmolpropshbaView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaView::max(self : ChemmolpropshbaView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaView::to_string(self : ChemmolpropshbaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_range_make(size : Int) -> ChemmolpropshbaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaRange::len(self : ChemmolpropshbaRange) -> Int { self.size }

pub fn ChemmolpropshbaRange::get(self : ChemmolpropshbaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaRange::set(self : ChemmolpropshbaRange, i : Int, v : Double) -> ChemmolpropshbaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaRange::sum(self : ChemmolpropshbaRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaRange::mean(self : ChemmolpropshbaRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaRange::scale(self : ChemmolpropshbaRange, f : Double) -> ChemmolpropshbaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaRange::add(self : ChemmolpropshbaRange, other : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaRange::copy(self : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaRange::fill(self : ChemmolpropshbaRange, v : Double) -> ChemmolpropshbaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaRange::min(self : ChemmolpropshbaRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaRange::max(self : ChemmolpropshbaRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaRange::to_string(self : ChemmolpropshbaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_slice_make(size : Int) -> ChemmolpropshbaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropshbaSlice::len(self : ChemmolpropshbaSlice) -> Int { self.size }

pub fn ChemmolpropshbaSlice::get(self : ChemmolpropshbaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropshbaSlice::set(self : ChemmolpropshbaSlice, i : Int, v : Double) -> ChemmolpropshbaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaSlice::sum(self : ChemmolpropshbaSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropshbaSlice::mean(self : ChemmolpropshbaSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropshbaSlice::scale(self : ChemmolpropshbaSlice, f : Double) -> ChemmolpropshbaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaSlice::add(self : ChemmolpropshbaSlice, other : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropshbaSlice::copy(self : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaSlice::fill(self : ChemmolpropshbaSlice, v : Double) -> ChemmolpropshbaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropshbaSlice::min(self : ChemmolpropshbaSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropshbaSlice::max(self : ChemmolpropshbaSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropshbaSlice::to_string(self : ChemmolpropshbaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

