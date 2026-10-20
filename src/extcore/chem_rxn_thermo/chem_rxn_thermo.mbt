///===
/// extcore/chem_rxn_thermo

pub(all) struct ChemrxnthermoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_thermo_make_point(x : Double, y : Double) -> ChemrxnthermoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_thermo_make_point3(x : Double, y : Double, z : Double) -> ChemrxnthermoPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnthermoPoint::x(self : ChemrxnthermoPoint) -> Double { self.x }

pub fn ChemrxnthermoPoint::y(self : ChemrxnthermoPoint) -> Double { self.y }

pub fn ChemrxnthermoPoint::z(self : ChemrxnthermoPoint) -> Double { self.z }

pub fn ChemrxnthermoPoint::label(self : ChemrxnthermoPoint) -> Int { self.label }

pub fn ChemrxnthermoPoint::dist(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnthermoPoint::add(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnthermoPoint::sub(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnthermoPoint::scale(self : ChemrxnthermoPoint, s : Double) -> ChemrxnthermoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnthermoPoint::dot(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnthermoPoint::cross(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnthermoPoint::norm(self : ChemrxnthermoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnthermoPoint::normalize(self : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnthermoPoint::negate(self : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnthermoPoint::mid(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnthermoPoint::lerp(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint, t : Double) -> ChemrxnthermoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnthermoPoint::to_string(self : ChemrxnthermoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnthermoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_thermo_make_series(vals : Array[Double], name : String) -> ChemrxnthermoSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnthermoSeries::len(self : ChemrxnthermoSeries) -> Int { self.vals.length() }

pub fn ChemrxnthermoSeries::sum(self : ChemrxnthermoSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnthermoSeries::mean(self : ChemrxnthermoSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnthermoSeries::min(self : ChemrxnthermoSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnthermoSeries::max(self : ChemrxnthermoSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnthermoSeries::range(self : ChemrxnthermoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnthermoSeries::variance(self : ChemrxnthermoSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnthermoSeries::std(self : ChemrxnthermoSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnthermoSeries::median(self : ChemrxnthermoSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnthermoSeries::scale(self : ChemrxnthermoSeries, f : Double) -> ChemrxnthermoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::add(self : ChemrxnthermoSeries, other : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::sub(self : ChemrxnthermoSeries, other : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::normalize(self : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnthermoSeries::cumsum(self : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnthermoSeries::to_string(self : ChemrxnthermoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnthermoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_thermo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnthermoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_thermo_matrix_identity(n : Int) -> ChemrxnthermoMatrix {
  let m = chem_rxn_thermo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnthermoMatrix::get(self : ChemrxnthermoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnthermoMatrix::transpose(self : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnthermoMatrix::add(self : ChemrxnthermoMatrix, other : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_thermo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnthermoMatrix::scale(self : ChemrxnthermoMatrix, s : Double) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnthermoMatrix::multiply(self : ChemrxnthermoMatrix, other : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if self.cols != other.rows { return chem_rxn_thermo_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_thermo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnthermoMatrix::trace(self : ChemrxnthermoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnthermoMatrix::det(self : ChemrxnthermoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnthermoMatrix::norm(self : ChemrxnthermoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnthermoMatrix::to_string(self : ChemrxnthermoMatrix) -> String {
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

pub(all) struct ChemrxnthermoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_thermo_make_vector(comps : Array[Double]) -> ChemrxnthermoVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_thermo_vector_zero(dim : Int) -> ChemrxnthermoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnthermoVector::add(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnthermoVector::sub(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnthermoVector::scale(self : ChemrxnthermoVector, s : Double) -> ChemrxnthermoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnthermoVector::dot(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnthermoVector::norm(self : ChemrxnthermoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnthermoVector::normalize(self : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnthermoVector::dist(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnthermoVector::to_string(self : ChemrxnthermoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnthermoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_frame_make(size : Int) -> ChemrxnthermoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoFrame::len(self : ChemrxnthermoFrame) -> Int { self.size }

pub fn ChemrxnthermoFrame::get(self : ChemrxnthermoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoFrame::set(self : ChemrxnthermoFrame, i : Int, v : Double) -> ChemrxnthermoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoFrame::sum(self : ChemrxnthermoFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoFrame::mean(self : ChemrxnthermoFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoFrame::scale(self : ChemrxnthermoFrame, f : Double) -> ChemrxnthermoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoFrame::add(self : ChemrxnthermoFrame, other : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoFrame::copy(self : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoFrame::fill(self : ChemrxnthermoFrame, v : Double) -> ChemrxnthermoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoFrame::min(self : ChemrxnthermoFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoFrame::max(self : ChemrxnthermoFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoFrame::to_string(self : ChemrxnthermoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_table_make(size : Int) -> ChemrxnthermoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoTable::len(self : ChemrxnthermoTable) -> Int { self.size }

pub fn ChemrxnthermoTable::get(self : ChemrxnthermoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoTable::set(self : ChemrxnthermoTable, i : Int, v : Double) -> ChemrxnthermoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoTable::sum(self : ChemrxnthermoTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoTable::mean(self : ChemrxnthermoTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoTable::scale(self : ChemrxnthermoTable, f : Double) -> ChemrxnthermoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoTable::add(self : ChemrxnthermoTable, other : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoTable::copy(self : ChemrxnthermoTable) -> ChemrxnthermoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoTable::fill(self : ChemrxnthermoTable, v : Double) -> ChemrxnthermoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoTable::min(self : ChemrxnthermoTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoTable::max(self : ChemrxnthermoTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoTable::to_string(self : ChemrxnthermoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_graphn_make(size : Int) -> ChemrxnthermoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoGraphN::len(self : ChemrxnthermoGraphN) -> Int { self.size }

pub fn ChemrxnthermoGraphN::get(self : ChemrxnthermoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoGraphN::set(self : ChemrxnthermoGraphN, i : Int, v : Double) -> ChemrxnthermoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoGraphN::sum(self : ChemrxnthermoGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoGraphN::mean(self : ChemrxnthermoGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoGraphN::scale(self : ChemrxnthermoGraphN, f : Double) -> ChemrxnthermoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoGraphN::add(self : ChemrxnthermoGraphN, other : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoGraphN::copy(self : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoGraphN::fill(self : ChemrxnthermoGraphN, v : Double) -> ChemrxnthermoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoGraphN::min(self : ChemrxnthermoGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoGraphN::max(self : ChemrxnthermoGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoGraphN::to_string(self : ChemrxnthermoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_node_make(size : Int) -> ChemrxnthermoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoNode::len(self : ChemrxnthermoNode) -> Int { self.size }

pub fn ChemrxnthermoNode::get(self : ChemrxnthermoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoNode::set(self : ChemrxnthermoNode, i : Int, v : Double) -> ChemrxnthermoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoNode::sum(self : ChemrxnthermoNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoNode::mean(self : ChemrxnthermoNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoNode::scale(self : ChemrxnthermoNode, f : Double) -> ChemrxnthermoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoNode::add(self : ChemrxnthermoNode, other : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoNode::copy(self : ChemrxnthermoNode) -> ChemrxnthermoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoNode::fill(self : ChemrxnthermoNode, v : Double) -> ChemrxnthermoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoNode::min(self : ChemrxnthermoNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoNode::max(self : ChemrxnthermoNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoNode::to_string(self : ChemrxnthermoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_edge_make(size : Int) -> ChemrxnthermoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoEdge::len(self : ChemrxnthermoEdge) -> Int { self.size }

pub fn ChemrxnthermoEdge::get(self : ChemrxnthermoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoEdge::set(self : ChemrxnthermoEdge, i : Int, v : Double) -> ChemrxnthermoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoEdge::sum(self : ChemrxnthermoEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoEdge::mean(self : ChemrxnthermoEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoEdge::scale(self : ChemrxnthermoEdge, f : Double) -> ChemrxnthermoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoEdge::add(self : ChemrxnthermoEdge, other : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoEdge::copy(self : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoEdge::fill(self : ChemrxnthermoEdge, v : Double) -> ChemrxnthermoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoEdge::min(self : ChemrxnthermoEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoEdge::max(self : ChemrxnthermoEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoEdge::to_string(self : ChemrxnthermoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_path_make(size : Int) -> ChemrxnthermoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoPath::len(self : ChemrxnthermoPath) -> Int { self.size }

pub fn ChemrxnthermoPath::get(self : ChemrxnthermoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoPath::set(self : ChemrxnthermoPath, i : Int, v : Double) -> ChemrxnthermoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoPath::sum(self : ChemrxnthermoPath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoPath::mean(self : ChemrxnthermoPath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoPath::scale(self : ChemrxnthermoPath, f : Double) -> ChemrxnthermoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoPath::add(self : ChemrxnthermoPath, other : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoPath::copy(self : ChemrxnthermoPath) -> ChemrxnthermoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoPath::fill(self : ChemrxnthermoPath, v : Double) -> ChemrxnthermoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoPath::min(self : ChemrxnthermoPath) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoPath::max(self : ChemrxnthermoPath) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoPath::to_string(self : ChemrxnthermoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cluster_make(size : Int) -> ChemrxnthermoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoCluster::len(self : ChemrxnthermoCluster) -> Int { self.size }

pub fn ChemrxnthermoCluster::get(self : ChemrxnthermoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoCluster::set(self : ChemrxnthermoCluster, i : Int, v : Double) -> ChemrxnthermoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCluster::sum(self : ChemrxnthermoCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoCluster::mean(self : ChemrxnthermoCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoCluster::scale(self : ChemrxnthermoCluster, f : Double) -> ChemrxnthermoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCluster::add(self : ChemrxnthermoCluster, other : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoCluster::copy(self : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCluster::fill(self : ChemrxnthermoCluster, v : Double) -> ChemrxnthermoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCluster::min(self : ChemrxnthermoCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoCluster::max(self : ChemrxnthermoCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoCluster::to_string(self : ChemrxnthermoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_model_make(size : Int) -> ChemrxnthermoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoModel::len(self : ChemrxnthermoModel) -> Int { self.size }

pub fn ChemrxnthermoModel::get(self : ChemrxnthermoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoModel::set(self : ChemrxnthermoModel, i : Int, v : Double) -> ChemrxnthermoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoModel::sum(self : ChemrxnthermoModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoModel::mean(self : ChemrxnthermoModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoModel::scale(self : ChemrxnthermoModel, f : Double) -> ChemrxnthermoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoModel::add(self : ChemrxnthermoModel, other : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoModel::copy(self : ChemrxnthermoModel) -> ChemrxnthermoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoModel::fill(self : ChemrxnthermoModel, v : Double) -> ChemrxnthermoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoModel::min(self : ChemrxnthermoModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoModel::max(self : ChemrxnthermoModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoModel::to_string(self : ChemrxnthermoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_layer_make(size : Int) -> ChemrxnthermoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoLayer::len(self : ChemrxnthermoLayer) -> Int { self.size }

pub fn ChemrxnthermoLayer::get(self : ChemrxnthermoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoLayer::set(self : ChemrxnthermoLayer, i : Int, v : Double) -> ChemrxnthermoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoLayer::sum(self : ChemrxnthermoLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoLayer::mean(self : ChemrxnthermoLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoLayer::scale(self : ChemrxnthermoLayer, f : Double) -> ChemrxnthermoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoLayer::add(self : ChemrxnthermoLayer, other : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoLayer::copy(self : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoLayer::fill(self : ChemrxnthermoLayer, v : Double) -> ChemrxnthermoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoLayer::min(self : ChemrxnthermoLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoLayer::max(self : ChemrxnthermoLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoLayer::to_string(self : ChemrxnthermoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_buffer_make(size : Int) -> ChemrxnthermoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoBuffer::len(self : ChemrxnthermoBuffer) -> Int { self.size }

pub fn ChemrxnthermoBuffer::get(self : ChemrxnthermoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoBuffer::set(self : ChemrxnthermoBuffer, i : Int, v : Double) -> ChemrxnthermoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoBuffer::sum(self : ChemrxnthermoBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoBuffer::mean(self : ChemrxnthermoBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoBuffer::scale(self : ChemrxnthermoBuffer, f : Double) -> ChemrxnthermoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoBuffer::add(self : ChemrxnthermoBuffer, other : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoBuffer::copy(self : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoBuffer::fill(self : ChemrxnthermoBuffer, v : Double) -> ChemrxnthermoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoBuffer::min(self : ChemrxnthermoBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoBuffer::max(self : ChemrxnthermoBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoBuffer::to_string(self : ChemrxnthermoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cursor_make(size : Int) -> ChemrxnthermoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoCursor::len(self : ChemrxnthermoCursor) -> Int { self.size }

pub fn ChemrxnthermoCursor::get(self : ChemrxnthermoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoCursor::set(self : ChemrxnthermoCursor, i : Int, v : Double) -> ChemrxnthermoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCursor::sum(self : ChemrxnthermoCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoCursor::mean(self : ChemrxnthermoCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoCursor::scale(self : ChemrxnthermoCursor, f : Double) -> ChemrxnthermoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCursor::add(self : ChemrxnthermoCursor, other : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoCursor::copy(self : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCursor::fill(self : ChemrxnthermoCursor, v : Double) -> ChemrxnthermoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoCursor::min(self : ChemrxnthermoCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoCursor::max(self : ChemrxnthermoCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoCursor::to_string(self : ChemrxnthermoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_view_make(size : Int) -> ChemrxnthermoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoView::len(self : ChemrxnthermoView) -> Int { self.size }

pub fn ChemrxnthermoView::get(self : ChemrxnthermoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoView::set(self : ChemrxnthermoView, i : Int, v : Double) -> ChemrxnthermoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoView::sum(self : ChemrxnthermoView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoView::mean(self : ChemrxnthermoView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoView::scale(self : ChemrxnthermoView, f : Double) -> ChemrxnthermoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoView::add(self : ChemrxnthermoView, other : ChemrxnthermoView) -> ChemrxnthermoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoView::copy(self : ChemrxnthermoView) -> ChemrxnthermoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoView::fill(self : ChemrxnthermoView, v : Double) -> ChemrxnthermoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoView::min(self : ChemrxnthermoView) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoView::max(self : ChemrxnthermoView) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoView::to_string(self : ChemrxnthermoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_range_make(size : Int) -> ChemrxnthermoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoRange::len(self : ChemrxnthermoRange) -> Int { self.size }

pub fn ChemrxnthermoRange::get(self : ChemrxnthermoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoRange::set(self : ChemrxnthermoRange, i : Int, v : Double) -> ChemrxnthermoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoRange::sum(self : ChemrxnthermoRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoRange::mean(self : ChemrxnthermoRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoRange::scale(self : ChemrxnthermoRange, f : Double) -> ChemrxnthermoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoRange::add(self : ChemrxnthermoRange, other : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoRange::copy(self : ChemrxnthermoRange) -> ChemrxnthermoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoRange::fill(self : ChemrxnthermoRange, v : Double) -> ChemrxnthermoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoRange::min(self : ChemrxnthermoRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoRange::max(self : ChemrxnthermoRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoRange::to_string(self : ChemrxnthermoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_slice_make(size : Int) -> ChemrxnthermoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnthermoSlice::len(self : ChemrxnthermoSlice) -> Int { self.size }

pub fn ChemrxnthermoSlice::get(self : ChemrxnthermoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnthermoSlice::set(self : ChemrxnthermoSlice, i : Int, v : Double) -> ChemrxnthermoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoSlice::sum(self : ChemrxnthermoSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnthermoSlice::mean(self : ChemrxnthermoSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnthermoSlice::scale(self : ChemrxnthermoSlice, f : Double) -> ChemrxnthermoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoSlice::add(self : ChemrxnthermoSlice, other : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnthermoSlice::copy(self : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoSlice::fill(self : ChemrxnthermoSlice, v : Double) -> ChemrxnthermoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnthermoSlice::min(self : ChemrxnthermoSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnthermoSlice::max(self : ChemrxnthermoSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnthermoSlice::to_string(self : ChemrxnthermoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

