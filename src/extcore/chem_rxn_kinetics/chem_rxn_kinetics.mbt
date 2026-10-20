///===
/// extcore/chem_rxn_kinetics

pub(all) struct ChemrxnkineticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_kinetics_make_point(x : Double, y : Double) -> ChemrxnkineticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_kinetics_make_point3(x : Double, y : Double, z : Double) -> ChemrxnkineticsPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnkineticsPoint::x(self : ChemrxnkineticsPoint) -> Double { self.x }

pub fn ChemrxnkineticsPoint::y(self : ChemrxnkineticsPoint) -> Double { self.y }

pub fn ChemrxnkineticsPoint::z(self : ChemrxnkineticsPoint) -> Double { self.z }

pub fn ChemrxnkineticsPoint::label(self : ChemrxnkineticsPoint) -> Int { self.label }

pub fn ChemrxnkineticsPoint::dist(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnkineticsPoint::add(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::sub(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::scale(self : ChemrxnkineticsPoint, s : Double) -> ChemrxnkineticsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnkineticsPoint::dot(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnkineticsPoint::cross(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnkineticsPoint::norm(self : ChemrxnkineticsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnkineticsPoint::normalize(self : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnkineticsPoint::negate(self : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::mid(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnkineticsPoint::lerp(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint, t : Double) -> ChemrxnkineticsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnkineticsPoint::to_string(self : ChemrxnkineticsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_kinetics_make_series(vals : Array[Double], name : String) -> ChemrxnkineticsSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnkineticsSeries::len(self : ChemrxnkineticsSeries) -> Int { self.vals.length() }

pub fn ChemrxnkineticsSeries::sum(self : ChemrxnkineticsSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnkineticsSeries::mean(self : ChemrxnkineticsSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnkineticsSeries::min(self : ChemrxnkineticsSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnkineticsSeries::max(self : ChemrxnkineticsSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnkineticsSeries::range(self : ChemrxnkineticsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnkineticsSeries::variance(self : ChemrxnkineticsSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnkineticsSeries::std(self : ChemrxnkineticsSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnkineticsSeries::median(self : ChemrxnkineticsSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnkineticsSeries::scale(self : ChemrxnkineticsSeries, f : Double) -> ChemrxnkineticsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::add(self : ChemrxnkineticsSeries, other : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::sub(self : ChemrxnkineticsSeries, other : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::normalize(self : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnkineticsSeries::cumsum(self : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnkineticsSeries::to_string(self : ChemrxnkineticsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnkineticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_kinetics_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnkineticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_kinetics_matrix_identity(n : Int) -> ChemrxnkineticsMatrix {
  let m = chem_rxn_kinetics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnkineticsMatrix::get(self : ChemrxnkineticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnkineticsMatrix::transpose(self : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnkineticsMatrix::add(self : ChemrxnkineticsMatrix, other : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_kinetics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnkineticsMatrix::scale(self : ChemrxnkineticsMatrix, s : Double) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnkineticsMatrix::multiply(self : ChemrxnkineticsMatrix, other : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if self.cols != other.rows { return chem_rxn_kinetics_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_kinetics_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnkineticsMatrix::trace(self : ChemrxnkineticsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnkineticsMatrix::det(self : ChemrxnkineticsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnkineticsMatrix::norm(self : ChemrxnkineticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnkineticsMatrix::to_string(self : ChemrxnkineticsMatrix) -> String {
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

pub(all) struct ChemrxnkineticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_kinetics_make_vector(comps : Array[Double]) -> ChemrxnkineticsVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_kinetics_vector_zero(dim : Int) -> ChemrxnkineticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnkineticsVector::add(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnkineticsVector::sub(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnkineticsVector::scale(self : ChemrxnkineticsVector, s : Double) -> ChemrxnkineticsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnkineticsVector::dot(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnkineticsVector::norm(self : ChemrxnkineticsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnkineticsVector::normalize(self : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnkineticsVector::dist(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnkineticsVector::to_string(self : ChemrxnkineticsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnkineticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_frame_make(size : Int) -> ChemrxnkineticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsFrame::len(self : ChemrxnkineticsFrame) -> Int { self.size }

pub fn ChemrxnkineticsFrame::get(self : ChemrxnkineticsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsFrame::set(self : ChemrxnkineticsFrame, i : Int, v : Double) -> ChemrxnkineticsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsFrame::sum(self : ChemrxnkineticsFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsFrame::mean(self : ChemrxnkineticsFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsFrame::scale(self : ChemrxnkineticsFrame, f : Double) -> ChemrxnkineticsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsFrame::add(self : ChemrxnkineticsFrame, other : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsFrame::copy(self : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsFrame::fill(self : ChemrxnkineticsFrame, v : Double) -> ChemrxnkineticsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsFrame::min(self : ChemrxnkineticsFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsFrame::max(self : ChemrxnkineticsFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsFrame::to_string(self : ChemrxnkineticsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_table_make(size : Int) -> ChemrxnkineticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsTable::len(self : ChemrxnkineticsTable) -> Int { self.size }

pub fn ChemrxnkineticsTable::get(self : ChemrxnkineticsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsTable::set(self : ChemrxnkineticsTable, i : Int, v : Double) -> ChemrxnkineticsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsTable::sum(self : ChemrxnkineticsTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsTable::mean(self : ChemrxnkineticsTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsTable::scale(self : ChemrxnkineticsTable, f : Double) -> ChemrxnkineticsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsTable::add(self : ChemrxnkineticsTable, other : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsTable::copy(self : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsTable::fill(self : ChemrxnkineticsTable, v : Double) -> ChemrxnkineticsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsTable::min(self : ChemrxnkineticsTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsTable::max(self : ChemrxnkineticsTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsTable::to_string(self : ChemrxnkineticsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_graphn_make(size : Int) -> ChemrxnkineticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsGraphN::len(self : ChemrxnkineticsGraphN) -> Int { self.size }

pub fn ChemrxnkineticsGraphN::get(self : ChemrxnkineticsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsGraphN::set(self : ChemrxnkineticsGraphN, i : Int, v : Double) -> ChemrxnkineticsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsGraphN::sum(self : ChemrxnkineticsGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsGraphN::mean(self : ChemrxnkineticsGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsGraphN::scale(self : ChemrxnkineticsGraphN, f : Double) -> ChemrxnkineticsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsGraphN::add(self : ChemrxnkineticsGraphN, other : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsGraphN::copy(self : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsGraphN::fill(self : ChemrxnkineticsGraphN, v : Double) -> ChemrxnkineticsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsGraphN::min(self : ChemrxnkineticsGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsGraphN::max(self : ChemrxnkineticsGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsGraphN::to_string(self : ChemrxnkineticsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_node_make(size : Int) -> ChemrxnkineticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsNode::len(self : ChemrxnkineticsNode) -> Int { self.size }

pub fn ChemrxnkineticsNode::get(self : ChemrxnkineticsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsNode::set(self : ChemrxnkineticsNode, i : Int, v : Double) -> ChemrxnkineticsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsNode::sum(self : ChemrxnkineticsNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsNode::mean(self : ChemrxnkineticsNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsNode::scale(self : ChemrxnkineticsNode, f : Double) -> ChemrxnkineticsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsNode::add(self : ChemrxnkineticsNode, other : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsNode::copy(self : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsNode::fill(self : ChemrxnkineticsNode, v : Double) -> ChemrxnkineticsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsNode::min(self : ChemrxnkineticsNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsNode::max(self : ChemrxnkineticsNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsNode::to_string(self : ChemrxnkineticsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_edge_make(size : Int) -> ChemrxnkineticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsEdge::len(self : ChemrxnkineticsEdge) -> Int { self.size }

pub fn ChemrxnkineticsEdge::get(self : ChemrxnkineticsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsEdge::set(self : ChemrxnkineticsEdge, i : Int, v : Double) -> ChemrxnkineticsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsEdge::sum(self : ChemrxnkineticsEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsEdge::mean(self : ChemrxnkineticsEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsEdge::scale(self : ChemrxnkineticsEdge, f : Double) -> ChemrxnkineticsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsEdge::add(self : ChemrxnkineticsEdge, other : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsEdge::copy(self : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsEdge::fill(self : ChemrxnkineticsEdge, v : Double) -> ChemrxnkineticsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsEdge::min(self : ChemrxnkineticsEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsEdge::max(self : ChemrxnkineticsEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsEdge::to_string(self : ChemrxnkineticsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_path_make(size : Int) -> ChemrxnkineticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsPath::len(self : ChemrxnkineticsPath) -> Int { self.size }

pub fn ChemrxnkineticsPath::get(self : ChemrxnkineticsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsPath::set(self : ChemrxnkineticsPath, i : Int, v : Double) -> ChemrxnkineticsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsPath::sum(self : ChemrxnkineticsPath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsPath::mean(self : ChemrxnkineticsPath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsPath::scale(self : ChemrxnkineticsPath, f : Double) -> ChemrxnkineticsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsPath::add(self : ChemrxnkineticsPath, other : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsPath::copy(self : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsPath::fill(self : ChemrxnkineticsPath, v : Double) -> ChemrxnkineticsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsPath::min(self : ChemrxnkineticsPath) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsPath::max(self : ChemrxnkineticsPath) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsPath::to_string(self : ChemrxnkineticsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cluster_make(size : Int) -> ChemrxnkineticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsCluster::len(self : ChemrxnkineticsCluster) -> Int { self.size }

pub fn ChemrxnkineticsCluster::get(self : ChemrxnkineticsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsCluster::set(self : ChemrxnkineticsCluster, i : Int, v : Double) -> ChemrxnkineticsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCluster::sum(self : ChemrxnkineticsCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsCluster::mean(self : ChemrxnkineticsCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsCluster::scale(self : ChemrxnkineticsCluster, f : Double) -> ChemrxnkineticsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCluster::add(self : ChemrxnkineticsCluster, other : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsCluster::copy(self : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCluster::fill(self : ChemrxnkineticsCluster, v : Double) -> ChemrxnkineticsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCluster::min(self : ChemrxnkineticsCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsCluster::max(self : ChemrxnkineticsCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsCluster::to_string(self : ChemrxnkineticsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_model_make(size : Int) -> ChemrxnkineticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsModel::len(self : ChemrxnkineticsModel) -> Int { self.size }

pub fn ChemrxnkineticsModel::get(self : ChemrxnkineticsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsModel::set(self : ChemrxnkineticsModel, i : Int, v : Double) -> ChemrxnkineticsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsModel::sum(self : ChemrxnkineticsModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsModel::mean(self : ChemrxnkineticsModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsModel::scale(self : ChemrxnkineticsModel, f : Double) -> ChemrxnkineticsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsModel::add(self : ChemrxnkineticsModel, other : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsModel::copy(self : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsModel::fill(self : ChemrxnkineticsModel, v : Double) -> ChemrxnkineticsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsModel::min(self : ChemrxnkineticsModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsModel::max(self : ChemrxnkineticsModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsModel::to_string(self : ChemrxnkineticsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_layer_make(size : Int) -> ChemrxnkineticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsLayer::len(self : ChemrxnkineticsLayer) -> Int { self.size }

pub fn ChemrxnkineticsLayer::get(self : ChemrxnkineticsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsLayer::set(self : ChemrxnkineticsLayer, i : Int, v : Double) -> ChemrxnkineticsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsLayer::sum(self : ChemrxnkineticsLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsLayer::mean(self : ChemrxnkineticsLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsLayer::scale(self : ChemrxnkineticsLayer, f : Double) -> ChemrxnkineticsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsLayer::add(self : ChemrxnkineticsLayer, other : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsLayer::copy(self : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsLayer::fill(self : ChemrxnkineticsLayer, v : Double) -> ChemrxnkineticsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsLayer::min(self : ChemrxnkineticsLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsLayer::max(self : ChemrxnkineticsLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsLayer::to_string(self : ChemrxnkineticsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_buffer_make(size : Int) -> ChemrxnkineticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsBuffer::len(self : ChemrxnkineticsBuffer) -> Int { self.size }

pub fn ChemrxnkineticsBuffer::get(self : ChemrxnkineticsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsBuffer::set(self : ChemrxnkineticsBuffer, i : Int, v : Double) -> ChemrxnkineticsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsBuffer::sum(self : ChemrxnkineticsBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsBuffer::mean(self : ChemrxnkineticsBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsBuffer::scale(self : ChemrxnkineticsBuffer, f : Double) -> ChemrxnkineticsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsBuffer::add(self : ChemrxnkineticsBuffer, other : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsBuffer::copy(self : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsBuffer::fill(self : ChemrxnkineticsBuffer, v : Double) -> ChemrxnkineticsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsBuffer::min(self : ChemrxnkineticsBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsBuffer::max(self : ChemrxnkineticsBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsBuffer::to_string(self : ChemrxnkineticsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cursor_make(size : Int) -> ChemrxnkineticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsCursor::len(self : ChemrxnkineticsCursor) -> Int { self.size }

pub fn ChemrxnkineticsCursor::get(self : ChemrxnkineticsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsCursor::set(self : ChemrxnkineticsCursor, i : Int, v : Double) -> ChemrxnkineticsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCursor::sum(self : ChemrxnkineticsCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsCursor::mean(self : ChemrxnkineticsCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsCursor::scale(self : ChemrxnkineticsCursor, f : Double) -> ChemrxnkineticsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCursor::add(self : ChemrxnkineticsCursor, other : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsCursor::copy(self : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCursor::fill(self : ChemrxnkineticsCursor, v : Double) -> ChemrxnkineticsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsCursor::min(self : ChemrxnkineticsCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsCursor::max(self : ChemrxnkineticsCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsCursor::to_string(self : ChemrxnkineticsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_view_make(size : Int) -> ChemrxnkineticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsView::len(self : ChemrxnkineticsView) -> Int { self.size }

pub fn ChemrxnkineticsView::get(self : ChemrxnkineticsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsView::set(self : ChemrxnkineticsView, i : Int, v : Double) -> ChemrxnkineticsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsView::sum(self : ChemrxnkineticsView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsView::mean(self : ChemrxnkineticsView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsView::scale(self : ChemrxnkineticsView, f : Double) -> ChemrxnkineticsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsView::add(self : ChemrxnkineticsView, other : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsView::copy(self : ChemrxnkineticsView) -> ChemrxnkineticsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsView::fill(self : ChemrxnkineticsView, v : Double) -> ChemrxnkineticsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsView::min(self : ChemrxnkineticsView) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsView::max(self : ChemrxnkineticsView) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsView::to_string(self : ChemrxnkineticsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_range_make(size : Int) -> ChemrxnkineticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsRange::len(self : ChemrxnkineticsRange) -> Int { self.size }

pub fn ChemrxnkineticsRange::get(self : ChemrxnkineticsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsRange::set(self : ChemrxnkineticsRange, i : Int, v : Double) -> ChemrxnkineticsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsRange::sum(self : ChemrxnkineticsRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsRange::mean(self : ChemrxnkineticsRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsRange::scale(self : ChemrxnkineticsRange, f : Double) -> ChemrxnkineticsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsRange::add(self : ChemrxnkineticsRange, other : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsRange::copy(self : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsRange::fill(self : ChemrxnkineticsRange, v : Double) -> ChemrxnkineticsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsRange::min(self : ChemrxnkineticsRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsRange::max(self : ChemrxnkineticsRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsRange::to_string(self : ChemrxnkineticsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_slice_make(size : Int) -> ChemrxnkineticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnkineticsSlice::len(self : ChemrxnkineticsSlice) -> Int { self.size }

pub fn ChemrxnkineticsSlice::get(self : ChemrxnkineticsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnkineticsSlice::set(self : ChemrxnkineticsSlice, i : Int, v : Double) -> ChemrxnkineticsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsSlice::sum(self : ChemrxnkineticsSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnkineticsSlice::mean(self : ChemrxnkineticsSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnkineticsSlice::scale(self : ChemrxnkineticsSlice, f : Double) -> ChemrxnkineticsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsSlice::add(self : ChemrxnkineticsSlice, other : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnkineticsSlice::copy(self : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsSlice::fill(self : ChemrxnkineticsSlice, v : Double) -> ChemrxnkineticsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnkineticsSlice::min(self : ChemrxnkineticsSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnkineticsSlice::max(self : ChemrxnkineticsSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnkineticsSlice::to_string(self : ChemrxnkineticsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

