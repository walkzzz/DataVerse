///===
/// extcore/chem_mol_repr_xyz

pub(all) struct ChemmolreprxyzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_xyz_make_point(x : Double, y : Double) -> ChemmolreprxyzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_xyz_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprxyzPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprxyzPoint::x(self : ChemmolreprxyzPoint) -> Double { self.x }

pub fn ChemmolreprxyzPoint::y(self : ChemmolreprxyzPoint) -> Double { self.y }

pub fn ChemmolreprxyzPoint::z(self : ChemmolreprxyzPoint) -> Double { self.z }

pub fn ChemmolreprxyzPoint::label(self : ChemmolreprxyzPoint) -> Int { self.label }

pub fn ChemmolreprxyzPoint::dist(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprxyzPoint::add(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::sub(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::scale(self : ChemmolreprxyzPoint, s : Double) -> ChemmolreprxyzPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprxyzPoint::dot(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprxyzPoint::cross(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprxyzPoint::norm(self : ChemmolreprxyzPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprxyzPoint::normalize(self : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprxyzPoint::negate(self : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::mid(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprxyzPoint::lerp(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint, t : Double) -> ChemmolreprxyzPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprxyzPoint::to_string(self : ChemmolreprxyzPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_xyz_make_series(vals : Array[Double], name : String) -> ChemmolreprxyzSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprxyzSeries::len(self : ChemmolreprxyzSeries) -> Int { self.vals.length() }

pub fn ChemmolreprxyzSeries::sum(self : ChemmolreprxyzSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprxyzSeries::mean(self : ChemmolreprxyzSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprxyzSeries::min(self : ChemmolreprxyzSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprxyzSeries::max(self : ChemmolreprxyzSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprxyzSeries::range(self : ChemmolreprxyzSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprxyzSeries::variance(self : ChemmolreprxyzSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprxyzSeries::std(self : ChemmolreprxyzSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprxyzSeries::median(self : ChemmolreprxyzSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprxyzSeries::scale(self : ChemmolreprxyzSeries, f : Double) -> ChemmolreprxyzSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::add(self : ChemmolreprxyzSeries, other : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::sub(self : ChemmolreprxyzSeries, other : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::normalize(self : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprxyzSeries::cumsum(self : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprxyzSeries::to_string(self : ChemmolreprxyzSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprxyzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_xyz_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprxyzMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_xyz_matrix_identity(n : Int) -> ChemmolreprxyzMatrix {
  let m = chem_mol_repr_xyz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprxyzMatrix::get(self : ChemmolreprxyzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprxyzMatrix::transpose(self : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprxyzMatrix::add(self : ChemmolreprxyzMatrix, other : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_xyz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprxyzMatrix::scale(self : ChemmolreprxyzMatrix, s : Double) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprxyzMatrix::multiply(self : ChemmolreprxyzMatrix, other : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if self.cols != other.rows { return chem_mol_repr_xyz_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_xyz_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolreprxyzMatrix::trace(self : ChemmolreprxyzMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprxyzMatrix::det(self : ChemmolreprxyzMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprxyzMatrix::norm(self : ChemmolreprxyzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprxyzMatrix::to_string(self : ChemmolreprxyzMatrix) -> String {
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

pub(all) struct ChemmolreprxyzVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_xyz_make_vector(comps : Array[Double]) -> ChemmolreprxyzVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_xyz_vector_zero(dim : Int) -> ChemmolreprxyzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprxyzVector::add(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprxyzVector::sub(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprxyzVector::scale(self : ChemmolreprxyzVector, s : Double) -> ChemmolreprxyzVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprxyzVector::dot(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprxyzVector::norm(self : ChemmolreprxyzVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprxyzVector::normalize(self : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprxyzVector::dist(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprxyzVector::to_string(self : ChemmolreprxyzVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprxyzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_frame_make(size : Int) -> ChemmolreprxyzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzFrame::len(self : ChemmolreprxyzFrame) -> Int { self.size }

pub fn ChemmolreprxyzFrame::get(self : ChemmolreprxyzFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzFrame::set(self : ChemmolreprxyzFrame, i : Int, v : Double) -> ChemmolreprxyzFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzFrame::sum(self : ChemmolreprxyzFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzFrame::mean(self : ChemmolreprxyzFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzFrame::scale(self : ChemmolreprxyzFrame, f : Double) -> ChemmolreprxyzFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzFrame::add(self : ChemmolreprxyzFrame, other : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzFrame::copy(self : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzFrame::fill(self : ChemmolreprxyzFrame, v : Double) -> ChemmolreprxyzFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzFrame::min(self : ChemmolreprxyzFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzFrame::max(self : ChemmolreprxyzFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzFrame::to_string(self : ChemmolreprxyzFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_table_make(size : Int) -> ChemmolreprxyzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzTable::len(self : ChemmolreprxyzTable) -> Int { self.size }

pub fn ChemmolreprxyzTable::get(self : ChemmolreprxyzTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzTable::set(self : ChemmolreprxyzTable, i : Int, v : Double) -> ChemmolreprxyzTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzTable::sum(self : ChemmolreprxyzTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzTable::mean(self : ChemmolreprxyzTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzTable::scale(self : ChemmolreprxyzTable, f : Double) -> ChemmolreprxyzTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzTable::add(self : ChemmolreprxyzTable, other : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzTable::copy(self : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzTable::fill(self : ChemmolreprxyzTable, v : Double) -> ChemmolreprxyzTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzTable::min(self : ChemmolreprxyzTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzTable::max(self : ChemmolreprxyzTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzTable::to_string(self : ChemmolreprxyzTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_graphn_make(size : Int) -> ChemmolreprxyzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzGraphN::len(self : ChemmolreprxyzGraphN) -> Int { self.size }

pub fn ChemmolreprxyzGraphN::get(self : ChemmolreprxyzGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzGraphN::set(self : ChemmolreprxyzGraphN, i : Int, v : Double) -> ChemmolreprxyzGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzGraphN::sum(self : ChemmolreprxyzGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzGraphN::mean(self : ChemmolreprxyzGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzGraphN::scale(self : ChemmolreprxyzGraphN, f : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzGraphN::add(self : ChemmolreprxyzGraphN, other : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzGraphN::copy(self : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzGraphN::fill(self : ChemmolreprxyzGraphN, v : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzGraphN::min(self : ChemmolreprxyzGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzGraphN::max(self : ChemmolreprxyzGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzGraphN::to_string(self : ChemmolreprxyzGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_node_make(size : Int) -> ChemmolreprxyzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzNode::len(self : ChemmolreprxyzNode) -> Int { self.size }

pub fn ChemmolreprxyzNode::get(self : ChemmolreprxyzNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzNode::set(self : ChemmolreprxyzNode, i : Int, v : Double) -> ChemmolreprxyzNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzNode::sum(self : ChemmolreprxyzNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzNode::mean(self : ChemmolreprxyzNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzNode::scale(self : ChemmolreprxyzNode, f : Double) -> ChemmolreprxyzNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzNode::add(self : ChemmolreprxyzNode, other : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzNode::copy(self : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzNode::fill(self : ChemmolreprxyzNode, v : Double) -> ChemmolreprxyzNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzNode::min(self : ChemmolreprxyzNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzNode::max(self : ChemmolreprxyzNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzNode::to_string(self : ChemmolreprxyzNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_edge_make(size : Int) -> ChemmolreprxyzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzEdge::len(self : ChemmolreprxyzEdge) -> Int { self.size }

pub fn ChemmolreprxyzEdge::get(self : ChemmolreprxyzEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzEdge::set(self : ChemmolreprxyzEdge, i : Int, v : Double) -> ChemmolreprxyzEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzEdge::sum(self : ChemmolreprxyzEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzEdge::mean(self : ChemmolreprxyzEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzEdge::scale(self : ChemmolreprxyzEdge, f : Double) -> ChemmolreprxyzEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzEdge::add(self : ChemmolreprxyzEdge, other : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzEdge::copy(self : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzEdge::fill(self : ChemmolreprxyzEdge, v : Double) -> ChemmolreprxyzEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzEdge::min(self : ChemmolreprxyzEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzEdge::max(self : ChemmolreprxyzEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzEdge::to_string(self : ChemmolreprxyzEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_path_make(size : Int) -> ChemmolreprxyzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzPath::len(self : ChemmolreprxyzPath) -> Int { self.size }

pub fn ChemmolreprxyzPath::get(self : ChemmolreprxyzPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzPath::set(self : ChemmolreprxyzPath, i : Int, v : Double) -> ChemmolreprxyzPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzPath::sum(self : ChemmolreprxyzPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzPath::mean(self : ChemmolreprxyzPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzPath::scale(self : ChemmolreprxyzPath, f : Double) -> ChemmolreprxyzPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzPath::add(self : ChemmolreprxyzPath, other : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzPath::copy(self : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzPath::fill(self : ChemmolreprxyzPath, v : Double) -> ChemmolreprxyzPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzPath::min(self : ChemmolreprxyzPath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzPath::max(self : ChemmolreprxyzPath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzPath::to_string(self : ChemmolreprxyzPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cluster_make(size : Int) -> ChemmolreprxyzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzCluster::len(self : ChemmolreprxyzCluster) -> Int { self.size }

pub fn ChemmolreprxyzCluster::get(self : ChemmolreprxyzCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzCluster::set(self : ChemmolreprxyzCluster, i : Int, v : Double) -> ChemmolreprxyzCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCluster::sum(self : ChemmolreprxyzCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzCluster::mean(self : ChemmolreprxyzCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzCluster::scale(self : ChemmolreprxyzCluster, f : Double) -> ChemmolreprxyzCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCluster::add(self : ChemmolreprxyzCluster, other : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzCluster::copy(self : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCluster::fill(self : ChemmolreprxyzCluster, v : Double) -> ChemmolreprxyzCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCluster::min(self : ChemmolreprxyzCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzCluster::max(self : ChemmolreprxyzCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzCluster::to_string(self : ChemmolreprxyzCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_model_make(size : Int) -> ChemmolreprxyzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzModel::len(self : ChemmolreprxyzModel) -> Int { self.size }

pub fn ChemmolreprxyzModel::get(self : ChemmolreprxyzModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzModel::set(self : ChemmolreprxyzModel, i : Int, v : Double) -> ChemmolreprxyzModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzModel::sum(self : ChemmolreprxyzModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzModel::mean(self : ChemmolreprxyzModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzModel::scale(self : ChemmolreprxyzModel, f : Double) -> ChemmolreprxyzModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzModel::add(self : ChemmolreprxyzModel, other : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzModel::copy(self : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzModel::fill(self : ChemmolreprxyzModel, v : Double) -> ChemmolreprxyzModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzModel::min(self : ChemmolreprxyzModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzModel::max(self : ChemmolreprxyzModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzModel::to_string(self : ChemmolreprxyzModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_layer_make(size : Int) -> ChemmolreprxyzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzLayer::len(self : ChemmolreprxyzLayer) -> Int { self.size }

pub fn ChemmolreprxyzLayer::get(self : ChemmolreprxyzLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzLayer::set(self : ChemmolreprxyzLayer, i : Int, v : Double) -> ChemmolreprxyzLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzLayer::sum(self : ChemmolreprxyzLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzLayer::mean(self : ChemmolreprxyzLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzLayer::scale(self : ChemmolreprxyzLayer, f : Double) -> ChemmolreprxyzLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzLayer::add(self : ChemmolreprxyzLayer, other : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzLayer::copy(self : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzLayer::fill(self : ChemmolreprxyzLayer, v : Double) -> ChemmolreprxyzLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzLayer::min(self : ChemmolreprxyzLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzLayer::max(self : ChemmolreprxyzLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzLayer::to_string(self : ChemmolreprxyzLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_buffer_make(size : Int) -> ChemmolreprxyzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzBuffer::len(self : ChemmolreprxyzBuffer) -> Int { self.size }

pub fn ChemmolreprxyzBuffer::get(self : ChemmolreprxyzBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzBuffer::set(self : ChemmolreprxyzBuffer, i : Int, v : Double) -> ChemmolreprxyzBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzBuffer::sum(self : ChemmolreprxyzBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzBuffer::mean(self : ChemmolreprxyzBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzBuffer::scale(self : ChemmolreprxyzBuffer, f : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzBuffer::add(self : ChemmolreprxyzBuffer, other : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzBuffer::copy(self : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzBuffer::fill(self : ChemmolreprxyzBuffer, v : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzBuffer::min(self : ChemmolreprxyzBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzBuffer::max(self : ChemmolreprxyzBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzBuffer::to_string(self : ChemmolreprxyzBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cursor_make(size : Int) -> ChemmolreprxyzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzCursor::len(self : ChemmolreprxyzCursor) -> Int { self.size }

pub fn ChemmolreprxyzCursor::get(self : ChemmolreprxyzCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzCursor::set(self : ChemmolreprxyzCursor, i : Int, v : Double) -> ChemmolreprxyzCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCursor::sum(self : ChemmolreprxyzCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzCursor::mean(self : ChemmolreprxyzCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzCursor::scale(self : ChemmolreprxyzCursor, f : Double) -> ChemmolreprxyzCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCursor::add(self : ChemmolreprxyzCursor, other : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzCursor::copy(self : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCursor::fill(self : ChemmolreprxyzCursor, v : Double) -> ChemmolreprxyzCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzCursor::min(self : ChemmolreprxyzCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzCursor::max(self : ChemmolreprxyzCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzCursor::to_string(self : ChemmolreprxyzCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_view_make(size : Int) -> ChemmolreprxyzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzView::len(self : ChemmolreprxyzView) -> Int { self.size }

pub fn ChemmolreprxyzView::get(self : ChemmolreprxyzView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzView::set(self : ChemmolreprxyzView, i : Int, v : Double) -> ChemmolreprxyzView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzView::sum(self : ChemmolreprxyzView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzView::mean(self : ChemmolreprxyzView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzView::scale(self : ChemmolreprxyzView, f : Double) -> ChemmolreprxyzView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzView::add(self : ChemmolreprxyzView, other : ChemmolreprxyzView) -> ChemmolreprxyzView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzView::copy(self : ChemmolreprxyzView) -> ChemmolreprxyzView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzView::fill(self : ChemmolreprxyzView, v : Double) -> ChemmolreprxyzView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzView::min(self : ChemmolreprxyzView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzView::max(self : ChemmolreprxyzView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzView::to_string(self : ChemmolreprxyzView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_range_make(size : Int) -> ChemmolreprxyzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzRange::len(self : ChemmolreprxyzRange) -> Int { self.size }

pub fn ChemmolreprxyzRange::get(self : ChemmolreprxyzRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzRange::set(self : ChemmolreprxyzRange, i : Int, v : Double) -> ChemmolreprxyzRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzRange::sum(self : ChemmolreprxyzRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzRange::mean(self : ChemmolreprxyzRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzRange::scale(self : ChemmolreprxyzRange, f : Double) -> ChemmolreprxyzRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzRange::add(self : ChemmolreprxyzRange, other : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzRange::copy(self : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzRange::fill(self : ChemmolreprxyzRange, v : Double) -> ChemmolreprxyzRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzRange::min(self : ChemmolreprxyzRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzRange::max(self : ChemmolreprxyzRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzRange::to_string(self : ChemmolreprxyzRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_slice_make(size : Int) -> ChemmolreprxyzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprxyzSlice::len(self : ChemmolreprxyzSlice) -> Int { self.size }

pub fn ChemmolreprxyzSlice::get(self : ChemmolreprxyzSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprxyzSlice::set(self : ChemmolreprxyzSlice, i : Int, v : Double) -> ChemmolreprxyzSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzSlice::sum(self : ChemmolreprxyzSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprxyzSlice::mean(self : ChemmolreprxyzSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprxyzSlice::scale(self : ChemmolreprxyzSlice, f : Double) -> ChemmolreprxyzSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzSlice::add(self : ChemmolreprxyzSlice, other : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprxyzSlice::copy(self : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzSlice::fill(self : ChemmolreprxyzSlice, v : Double) -> ChemmolreprxyzSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprxyzSlice::min(self : ChemmolreprxyzSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprxyzSlice::max(self : ChemmolreprxyzSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprxyzSlice::to_string(self : ChemmolreprxyzSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

