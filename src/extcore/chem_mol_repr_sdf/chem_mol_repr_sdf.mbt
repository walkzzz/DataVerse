///===
/// extcore/chem_mol_repr_sdf

pub(all) struct ChemmolreprsdfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_sdf_make_point(x : Double, y : Double) -> ChemmolreprsdfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_sdf_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsdfPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprsdfPoint::x(self : ChemmolreprsdfPoint) -> Double { self.x }

pub fn ChemmolreprsdfPoint::y(self : ChemmolreprsdfPoint) -> Double { self.y }

pub fn ChemmolreprsdfPoint::z(self : ChemmolreprsdfPoint) -> Double { self.z }

pub fn ChemmolreprsdfPoint::label(self : ChemmolreprsdfPoint) -> Int { self.label }

pub fn ChemmolreprsdfPoint::dist(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprsdfPoint::add(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::sub(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::scale(self : ChemmolreprsdfPoint, s : Double) -> ChemmolreprsdfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprsdfPoint::dot(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprsdfPoint::cross(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprsdfPoint::norm(self : ChemmolreprsdfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprsdfPoint::normalize(self : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsdfPoint::negate(self : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::mid(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprsdfPoint::lerp(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint, t : Double) -> ChemmolreprsdfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprsdfPoint::to_string(self : ChemmolreprsdfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_sdf_make_series(vals : Array[Double], name : String) -> ChemmolreprsdfSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprsdfSeries::len(self : ChemmolreprsdfSeries) -> Int { self.vals.length() }

pub fn ChemmolreprsdfSeries::sum(self : ChemmolreprsdfSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprsdfSeries::mean(self : ChemmolreprsdfSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprsdfSeries::min(self : ChemmolreprsdfSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprsdfSeries::max(self : ChemmolreprsdfSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprsdfSeries::range(self : ChemmolreprsdfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprsdfSeries::variance(self : ChemmolreprsdfSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprsdfSeries::std(self : ChemmolreprsdfSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprsdfSeries::median(self : ChemmolreprsdfSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprsdfSeries::scale(self : ChemmolreprsdfSeries, f : Double) -> ChemmolreprsdfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::add(self : ChemmolreprsdfSeries, other : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::sub(self : ChemmolreprsdfSeries, other : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::normalize(self : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprsdfSeries::cumsum(self : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprsdfSeries::to_string(self : ChemmolreprsdfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsdfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_sdf_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsdfMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_mol_repr_sdf_matrix_identity(n : Int) -> ChemmolreprsdfMatrix {
  let m = chem_mol_repr_sdf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprsdfMatrix::get(self : ChemmolreprsdfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprsdfMatrix::transpose(self : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprsdfMatrix::add(self : ChemmolreprsdfMatrix, other : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_sdf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprsdfMatrix::scale(self : ChemmolreprsdfMatrix, s : Double) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprsdfMatrix::multiply(self : ChemmolreprsdfMatrix, other : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if self.cols != other.rows { return chem_mol_repr_sdf_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_sdf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolreprsdfMatrix::trace(self : ChemmolreprsdfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprsdfMatrix::det(self : ChemmolreprsdfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprsdfMatrix::norm(self : ChemmolreprsdfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprsdfMatrix::to_string(self : ChemmolreprsdfMatrix) -> String {
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

pub(all) struct ChemmolreprsdfVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_sdf_make_vector(comps : Array[Double]) -> ChemmolreprsdfVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_sdf_vector_zero(dim : Int) -> ChemmolreprsdfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprsdfVector::add(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsdfVector::sub(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsdfVector::scale(self : ChemmolreprsdfVector, s : Double) -> ChemmolreprsdfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprsdfVector::dot(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprsdfVector::norm(self : ChemmolreprsdfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprsdfVector::normalize(self : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsdfVector::dist(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprsdfVector::to_string(self : ChemmolreprsdfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsdfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_frame_make(size : Int) -> ChemmolreprsdfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfFrame::len(self : ChemmolreprsdfFrame) -> Int { self.size }

pub fn ChemmolreprsdfFrame::get(self : ChemmolreprsdfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfFrame::set(self : ChemmolreprsdfFrame, i : Int, v : Double) -> ChemmolreprsdfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfFrame::sum(self : ChemmolreprsdfFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfFrame::mean(self : ChemmolreprsdfFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfFrame::scale(self : ChemmolreprsdfFrame, f : Double) -> ChemmolreprsdfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfFrame::add(self : ChemmolreprsdfFrame, other : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfFrame::copy(self : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfFrame::fill(self : ChemmolreprsdfFrame, v : Double) -> ChemmolreprsdfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfFrame::min(self : ChemmolreprsdfFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfFrame::max(self : ChemmolreprsdfFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfFrame::to_string(self : ChemmolreprsdfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_table_make(size : Int) -> ChemmolreprsdfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfTable::len(self : ChemmolreprsdfTable) -> Int { self.size }

pub fn ChemmolreprsdfTable::get(self : ChemmolreprsdfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfTable::set(self : ChemmolreprsdfTable, i : Int, v : Double) -> ChemmolreprsdfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfTable::sum(self : ChemmolreprsdfTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfTable::mean(self : ChemmolreprsdfTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfTable::scale(self : ChemmolreprsdfTable, f : Double) -> ChemmolreprsdfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfTable::add(self : ChemmolreprsdfTable, other : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfTable::copy(self : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfTable::fill(self : ChemmolreprsdfTable, v : Double) -> ChemmolreprsdfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfTable::min(self : ChemmolreprsdfTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfTable::max(self : ChemmolreprsdfTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfTable::to_string(self : ChemmolreprsdfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_graphn_make(size : Int) -> ChemmolreprsdfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfGraphN::len(self : ChemmolreprsdfGraphN) -> Int { self.size }

pub fn ChemmolreprsdfGraphN::get(self : ChemmolreprsdfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfGraphN::set(self : ChemmolreprsdfGraphN, i : Int, v : Double) -> ChemmolreprsdfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfGraphN::sum(self : ChemmolreprsdfGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfGraphN::mean(self : ChemmolreprsdfGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfGraphN::scale(self : ChemmolreprsdfGraphN, f : Double) -> ChemmolreprsdfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfGraphN::add(self : ChemmolreprsdfGraphN, other : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfGraphN::copy(self : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfGraphN::fill(self : ChemmolreprsdfGraphN, v : Double) -> ChemmolreprsdfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfGraphN::min(self : ChemmolreprsdfGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfGraphN::max(self : ChemmolreprsdfGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfGraphN::to_string(self : ChemmolreprsdfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_node_make(size : Int) -> ChemmolreprsdfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfNode::len(self : ChemmolreprsdfNode) -> Int { self.size }

pub fn ChemmolreprsdfNode::get(self : ChemmolreprsdfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfNode::set(self : ChemmolreprsdfNode, i : Int, v : Double) -> ChemmolreprsdfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfNode::sum(self : ChemmolreprsdfNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfNode::mean(self : ChemmolreprsdfNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfNode::scale(self : ChemmolreprsdfNode, f : Double) -> ChemmolreprsdfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfNode::add(self : ChemmolreprsdfNode, other : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfNode::copy(self : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfNode::fill(self : ChemmolreprsdfNode, v : Double) -> ChemmolreprsdfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfNode::min(self : ChemmolreprsdfNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfNode::max(self : ChemmolreprsdfNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfNode::to_string(self : ChemmolreprsdfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_edge_make(size : Int) -> ChemmolreprsdfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfEdge::len(self : ChemmolreprsdfEdge) -> Int { self.size }

pub fn ChemmolreprsdfEdge::get(self : ChemmolreprsdfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfEdge::set(self : ChemmolreprsdfEdge, i : Int, v : Double) -> ChemmolreprsdfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfEdge::sum(self : ChemmolreprsdfEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfEdge::mean(self : ChemmolreprsdfEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfEdge::scale(self : ChemmolreprsdfEdge, f : Double) -> ChemmolreprsdfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfEdge::add(self : ChemmolreprsdfEdge, other : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfEdge::copy(self : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfEdge::fill(self : ChemmolreprsdfEdge, v : Double) -> ChemmolreprsdfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfEdge::min(self : ChemmolreprsdfEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfEdge::max(self : ChemmolreprsdfEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfEdge::to_string(self : ChemmolreprsdfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_path_make(size : Int) -> ChemmolreprsdfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfPath::len(self : ChemmolreprsdfPath) -> Int { self.size }

pub fn ChemmolreprsdfPath::get(self : ChemmolreprsdfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfPath::set(self : ChemmolreprsdfPath, i : Int, v : Double) -> ChemmolreprsdfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfPath::sum(self : ChemmolreprsdfPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfPath::mean(self : ChemmolreprsdfPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfPath::scale(self : ChemmolreprsdfPath, f : Double) -> ChemmolreprsdfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfPath::add(self : ChemmolreprsdfPath, other : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfPath::copy(self : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfPath::fill(self : ChemmolreprsdfPath, v : Double) -> ChemmolreprsdfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfPath::min(self : ChemmolreprsdfPath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfPath::max(self : ChemmolreprsdfPath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfPath::to_string(self : ChemmolreprsdfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cluster_make(size : Int) -> ChemmolreprsdfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfCluster::len(self : ChemmolreprsdfCluster) -> Int { self.size }

pub fn ChemmolreprsdfCluster::get(self : ChemmolreprsdfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfCluster::set(self : ChemmolreprsdfCluster, i : Int, v : Double) -> ChemmolreprsdfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCluster::sum(self : ChemmolreprsdfCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfCluster::mean(self : ChemmolreprsdfCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfCluster::scale(self : ChemmolreprsdfCluster, f : Double) -> ChemmolreprsdfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCluster::add(self : ChemmolreprsdfCluster, other : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfCluster::copy(self : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCluster::fill(self : ChemmolreprsdfCluster, v : Double) -> ChemmolreprsdfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCluster::min(self : ChemmolreprsdfCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfCluster::max(self : ChemmolreprsdfCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfCluster::to_string(self : ChemmolreprsdfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_model_make(size : Int) -> ChemmolreprsdfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfModel::len(self : ChemmolreprsdfModel) -> Int { self.size }

pub fn ChemmolreprsdfModel::get(self : ChemmolreprsdfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfModel::set(self : ChemmolreprsdfModel, i : Int, v : Double) -> ChemmolreprsdfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfModel::sum(self : ChemmolreprsdfModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfModel::mean(self : ChemmolreprsdfModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfModel::scale(self : ChemmolreprsdfModel, f : Double) -> ChemmolreprsdfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfModel::add(self : ChemmolreprsdfModel, other : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfModel::copy(self : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfModel::fill(self : ChemmolreprsdfModel, v : Double) -> ChemmolreprsdfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfModel::min(self : ChemmolreprsdfModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfModel::max(self : ChemmolreprsdfModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfModel::to_string(self : ChemmolreprsdfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_layer_make(size : Int) -> ChemmolreprsdfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfLayer::len(self : ChemmolreprsdfLayer) -> Int { self.size }

pub fn ChemmolreprsdfLayer::get(self : ChemmolreprsdfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfLayer::set(self : ChemmolreprsdfLayer, i : Int, v : Double) -> ChemmolreprsdfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfLayer::sum(self : ChemmolreprsdfLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfLayer::mean(self : ChemmolreprsdfLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfLayer::scale(self : ChemmolreprsdfLayer, f : Double) -> ChemmolreprsdfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfLayer::add(self : ChemmolreprsdfLayer, other : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfLayer::copy(self : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfLayer::fill(self : ChemmolreprsdfLayer, v : Double) -> ChemmolreprsdfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfLayer::min(self : ChemmolreprsdfLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfLayer::max(self : ChemmolreprsdfLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfLayer::to_string(self : ChemmolreprsdfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_buffer_make(size : Int) -> ChemmolreprsdfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfBuffer::len(self : ChemmolreprsdfBuffer) -> Int { self.size }

pub fn ChemmolreprsdfBuffer::get(self : ChemmolreprsdfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfBuffer::set(self : ChemmolreprsdfBuffer, i : Int, v : Double) -> ChemmolreprsdfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfBuffer::sum(self : ChemmolreprsdfBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfBuffer::mean(self : ChemmolreprsdfBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfBuffer::scale(self : ChemmolreprsdfBuffer, f : Double) -> ChemmolreprsdfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfBuffer::add(self : ChemmolreprsdfBuffer, other : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfBuffer::copy(self : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfBuffer::fill(self : ChemmolreprsdfBuffer, v : Double) -> ChemmolreprsdfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfBuffer::min(self : ChemmolreprsdfBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfBuffer::max(self : ChemmolreprsdfBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfBuffer::to_string(self : ChemmolreprsdfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cursor_make(size : Int) -> ChemmolreprsdfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfCursor::len(self : ChemmolreprsdfCursor) -> Int { self.size }

pub fn ChemmolreprsdfCursor::get(self : ChemmolreprsdfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfCursor::set(self : ChemmolreprsdfCursor, i : Int, v : Double) -> ChemmolreprsdfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCursor::sum(self : ChemmolreprsdfCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfCursor::mean(self : ChemmolreprsdfCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfCursor::scale(self : ChemmolreprsdfCursor, f : Double) -> ChemmolreprsdfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCursor::add(self : ChemmolreprsdfCursor, other : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfCursor::copy(self : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCursor::fill(self : ChemmolreprsdfCursor, v : Double) -> ChemmolreprsdfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfCursor::min(self : ChemmolreprsdfCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfCursor::max(self : ChemmolreprsdfCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfCursor::to_string(self : ChemmolreprsdfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_view_make(size : Int) -> ChemmolreprsdfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfView::len(self : ChemmolreprsdfView) -> Int { self.size }

pub fn ChemmolreprsdfView::get(self : ChemmolreprsdfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfView::set(self : ChemmolreprsdfView, i : Int, v : Double) -> ChemmolreprsdfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfView::sum(self : ChemmolreprsdfView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfView::mean(self : ChemmolreprsdfView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfView::scale(self : ChemmolreprsdfView, f : Double) -> ChemmolreprsdfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfView::add(self : ChemmolreprsdfView, other : ChemmolreprsdfView) -> ChemmolreprsdfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfView::copy(self : ChemmolreprsdfView) -> ChemmolreprsdfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfView::fill(self : ChemmolreprsdfView, v : Double) -> ChemmolreprsdfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfView::min(self : ChemmolreprsdfView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfView::max(self : ChemmolreprsdfView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfView::to_string(self : ChemmolreprsdfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_range_make(size : Int) -> ChemmolreprsdfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfRange::len(self : ChemmolreprsdfRange) -> Int { self.size }

pub fn ChemmolreprsdfRange::get(self : ChemmolreprsdfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfRange::set(self : ChemmolreprsdfRange, i : Int, v : Double) -> ChemmolreprsdfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfRange::sum(self : ChemmolreprsdfRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfRange::mean(self : ChemmolreprsdfRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfRange::scale(self : ChemmolreprsdfRange, f : Double) -> ChemmolreprsdfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfRange::add(self : ChemmolreprsdfRange, other : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfRange::copy(self : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfRange::fill(self : ChemmolreprsdfRange, v : Double) -> ChemmolreprsdfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfRange::min(self : ChemmolreprsdfRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfRange::max(self : ChemmolreprsdfRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfRange::to_string(self : ChemmolreprsdfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_slice_make(size : Int) -> ChemmolreprsdfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsdfSlice::len(self : ChemmolreprsdfSlice) -> Int { self.size }

pub fn ChemmolreprsdfSlice::get(self : ChemmolreprsdfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsdfSlice::set(self : ChemmolreprsdfSlice, i : Int, v : Double) -> ChemmolreprsdfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfSlice::sum(self : ChemmolreprsdfSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsdfSlice::mean(self : ChemmolreprsdfSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsdfSlice::scale(self : ChemmolreprsdfSlice, f : Double) -> ChemmolreprsdfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfSlice::add(self : ChemmolreprsdfSlice, other : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsdfSlice::copy(self : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfSlice::fill(self : ChemmolreprsdfSlice, v : Double) -> ChemmolreprsdfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsdfSlice::min(self : ChemmolreprsdfSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsdfSlice::max(self : ChemmolreprsdfSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsdfSlice::to_string(self : ChemmolreprsdfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

