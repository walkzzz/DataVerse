///===
/// extcore/bio_seq_assembly_string

pub(all) struct BioseqassemblystringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_string_make_point(x : Double, y : Double) -> BioseqassemblystringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_string_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblystringPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblystringPoint::x(self : BioseqassemblystringPoint) -> Double { self.x }

pub fn BioseqassemblystringPoint::y(self : BioseqassemblystringPoint) -> Double { self.y }

pub fn BioseqassemblystringPoint::z(self : BioseqassemblystringPoint) -> Double { self.z }

pub fn BioseqassemblystringPoint::label(self : BioseqassemblystringPoint) -> Int { self.label }

pub fn BioseqassemblystringPoint::dist(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblystringPoint::add(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblystringPoint::sub(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblystringPoint::scale(self : BioseqassemblystringPoint, s : Double) -> BioseqassemblystringPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblystringPoint::dot(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblystringPoint::cross(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblystringPoint::norm(self : BioseqassemblystringPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblystringPoint::normalize(self : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblystringPoint::negate(self : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblystringPoint::mid(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblystringPoint::lerp(self : BioseqassemblystringPoint, other : BioseqassemblystringPoint, t : Double) -> BioseqassemblystringPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblystringPoint::to_string(self : BioseqassemblystringPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblystringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_string_make_series(vals : Array[Double], name : String) -> BioseqassemblystringSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblystringSeries::len(self : BioseqassemblystringSeries) -> Int { self.vals.length() }

pub fn BioseqassemblystringSeries::sum(self : BioseqassemblystringSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblystringSeries::mean(self : BioseqassemblystringSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblystringSeries::min(self : BioseqassemblystringSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblystringSeries::max(self : BioseqassemblystringSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblystringSeries::range(self : BioseqassemblystringSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblystringSeries::variance(self : BioseqassemblystringSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblystringSeries::std(self : BioseqassemblystringSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblystringSeries::median(self : BioseqassemblystringSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblystringSeries::scale(self : BioseqassemblystringSeries, f : Double) -> BioseqassemblystringSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblystringSeries::add(self : BioseqassemblystringSeries, other : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblystringSeries::sub(self : BioseqassemblystringSeries, other : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblystringSeries::normalize(self : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblystringSeries::cumsum(self : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblystringSeries::to_string(self : BioseqassemblystringSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblystringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_string_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblystringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_string_matrix_identity(n : Int) -> BioseqassemblystringMatrix {
  let m = bio_seq_assembly_string_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblystringMatrix::get(self : BioseqassemblystringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblystringMatrix::transpose(self : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblystringMatrix::add(self : BioseqassemblystringMatrix, other : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_string_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblystringMatrix::scale(self : BioseqassemblystringMatrix, s : Double) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblystringMatrix::multiply(self : BioseqassemblystringMatrix, other : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if self.cols != other.rows { return bio_seq_assembly_string_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_string_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblystringMatrix::trace(self : BioseqassemblystringMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblystringMatrix::det(self : BioseqassemblystringMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblystringMatrix::norm(self : BioseqassemblystringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblystringMatrix::to_string(self : BioseqassemblystringMatrix) -> String {
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

pub(all) struct BioseqassemblystringVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_string_make_vector(comps : Array[Double]) -> BioseqassemblystringVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_string_vector_zero(dim : Int) -> BioseqassemblystringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblystringVector::add(self : BioseqassemblystringVector, other : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblystringVector::sub(self : BioseqassemblystringVector, other : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblystringVector::scale(self : BioseqassemblystringVector, s : Double) -> BioseqassemblystringVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblystringVector::dot(self : BioseqassemblystringVector, other : BioseqassemblystringVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblystringVector::norm(self : BioseqassemblystringVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblystringVector::normalize(self : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblystringVector::dist(self : BioseqassemblystringVector, other : BioseqassemblystringVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblystringVector::to_string(self : BioseqassemblystringVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblystringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_frame_make(size : Int) -> BioseqassemblystringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringFrame::len(self : BioseqassemblystringFrame) -> Int { self.size }

pub fn BioseqassemblystringFrame::get(self : BioseqassemblystringFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringFrame::set(self : BioseqassemblystringFrame, i : Int, v : Double) -> BioseqassemblystringFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringFrame::sum(self : BioseqassemblystringFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringFrame::mean(self : BioseqassemblystringFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringFrame::scale(self : BioseqassemblystringFrame, f : Double) -> BioseqassemblystringFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringFrame::add(self : BioseqassemblystringFrame, other : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringFrame::copy(self : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringFrame::fill(self : BioseqassemblystringFrame, v : Double) -> BioseqassemblystringFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringFrame::min(self : BioseqassemblystringFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringFrame::max(self : BioseqassemblystringFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringFrame::to_string(self : BioseqassemblystringFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_table_make(size : Int) -> BioseqassemblystringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringTable::len(self : BioseqassemblystringTable) -> Int { self.size }

pub fn BioseqassemblystringTable::get(self : BioseqassemblystringTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringTable::set(self : BioseqassemblystringTable, i : Int, v : Double) -> BioseqassemblystringTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringTable::sum(self : BioseqassemblystringTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringTable::mean(self : BioseqassemblystringTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringTable::scale(self : BioseqassemblystringTable, f : Double) -> BioseqassemblystringTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringTable::add(self : BioseqassemblystringTable, other : BioseqassemblystringTable) -> BioseqassemblystringTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringTable::copy(self : BioseqassemblystringTable) -> BioseqassemblystringTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringTable::fill(self : BioseqassemblystringTable, v : Double) -> BioseqassemblystringTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringTable::min(self : BioseqassemblystringTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringTable::max(self : BioseqassemblystringTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringTable::to_string(self : BioseqassemblystringTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_graphn_make(size : Int) -> BioseqassemblystringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringGraphN::len(self : BioseqassemblystringGraphN) -> Int { self.size }

pub fn BioseqassemblystringGraphN::get(self : BioseqassemblystringGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringGraphN::set(self : BioseqassemblystringGraphN, i : Int, v : Double) -> BioseqassemblystringGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringGraphN::sum(self : BioseqassemblystringGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringGraphN::mean(self : BioseqassemblystringGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringGraphN::scale(self : BioseqassemblystringGraphN, f : Double) -> BioseqassemblystringGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringGraphN::add(self : BioseqassemblystringGraphN, other : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringGraphN::copy(self : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringGraphN::fill(self : BioseqassemblystringGraphN, v : Double) -> BioseqassemblystringGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringGraphN::min(self : BioseqassemblystringGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringGraphN::max(self : BioseqassemblystringGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringGraphN::to_string(self : BioseqassemblystringGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_node_make(size : Int) -> BioseqassemblystringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringNode::len(self : BioseqassemblystringNode) -> Int { self.size }

pub fn BioseqassemblystringNode::get(self : BioseqassemblystringNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringNode::set(self : BioseqassemblystringNode, i : Int, v : Double) -> BioseqassemblystringNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringNode::sum(self : BioseqassemblystringNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringNode::mean(self : BioseqassemblystringNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringNode::scale(self : BioseqassemblystringNode, f : Double) -> BioseqassemblystringNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringNode::add(self : BioseqassemblystringNode, other : BioseqassemblystringNode) -> BioseqassemblystringNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringNode::copy(self : BioseqassemblystringNode) -> BioseqassemblystringNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringNode::fill(self : BioseqassemblystringNode, v : Double) -> BioseqassemblystringNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringNode::min(self : BioseqassemblystringNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringNode::max(self : BioseqassemblystringNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringNode::to_string(self : BioseqassemblystringNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_edge_make(size : Int) -> BioseqassemblystringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringEdge::len(self : BioseqassemblystringEdge) -> Int { self.size }

pub fn BioseqassemblystringEdge::get(self : BioseqassemblystringEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringEdge::set(self : BioseqassemblystringEdge, i : Int, v : Double) -> BioseqassemblystringEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringEdge::sum(self : BioseqassemblystringEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringEdge::mean(self : BioseqassemblystringEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringEdge::scale(self : BioseqassemblystringEdge, f : Double) -> BioseqassemblystringEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringEdge::add(self : BioseqassemblystringEdge, other : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringEdge::copy(self : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringEdge::fill(self : BioseqassemblystringEdge, v : Double) -> BioseqassemblystringEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringEdge::min(self : BioseqassemblystringEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringEdge::max(self : BioseqassemblystringEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringEdge::to_string(self : BioseqassemblystringEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_path_make(size : Int) -> BioseqassemblystringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringPath::len(self : BioseqassemblystringPath) -> Int { self.size }

pub fn BioseqassemblystringPath::get(self : BioseqassemblystringPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringPath::set(self : BioseqassemblystringPath, i : Int, v : Double) -> BioseqassemblystringPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringPath::sum(self : BioseqassemblystringPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringPath::mean(self : BioseqassemblystringPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringPath::scale(self : BioseqassemblystringPath, f : Double) -> BioseqassemblystringPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringPath::add(self : BioseqassemblystringPath, other : BioseqassemblystringPath) -> BioseqassemblystringPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringPath::copy(self : BioseqassemblystringPath) -> BioseqassemblystringPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringPath::fill(self : BioseqassemblystringPath, v : Double) -> BioseqassemblystringPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringPath::min(self : BioseqassemblystringPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringPath::max(self : BioseqassemblystringPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringPath::to_string(self : BioseqassemblystringPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cluster_make(size : Int) -> BioseqassemblystringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringCluster::len(self : BioseqassemblystringCluster) -> Int { self.size }

pub fn BioseqassemblystringCluster::get(self : BioseqassemblystringCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringCluster::set(self : BioseqassemblystringCluster, i : Int, v : Double) -> BioseqassemblystringCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCluster::sum(self : BioseqassemblystringCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringCluster::mean(self : BioseqassemblystringCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringCluster::scale(self : BioseqassemblystringCluster, f : Double) -> BioseqassemblystringCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCluster::add(self : BioseqassemblystringCluster, other : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringCluster::copy(self : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCluster::fill(self : BioseqassemblystringCluster, v : Double) -> BioseqassemblystringCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCluster::min(self : BioseqassemblystringCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringCluster::max(self : BioseqassemblystringCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringCluster::to_string(self : BioseqassemblystringCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_model_make(size : Int) -> BioseqassemblystringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringModel::len(self : BioseqassemblystringModel) -> Int { self.size }

pub fn BioseqassemblystringModel::get(self : BioseqassemblystringModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringModel::set(self : BioseqassemblystringModel, i : Int, v : Double) -> BioseqassemblystringModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringModel::sum(self : BioseqassemblystringModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringModel::mean(self : BioseqassemblystringModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringModel::scale(self : BioseqassemblystringModel, f : Double) -> BioseqassemblystringModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringModel::add(self : BioseqassemblystringModel, other : BioseqassemblystringModel) -> BioseqassemblystringModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringModel::copy(self : BioseqassemblystringModel) -> BioseqassemblystringModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringModel::fill(self : BioseqassemblystringModel, v : Double) -> BioseqassemblystringModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringModel::min(self : BioseqassemblystringModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringModel::max(self : BioseqassemblystringModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringModel::to_string(self : BioseqassemblystringModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_layer_make(size : Int) -> BioseqassemblystringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringLayer::len(self : BioseqassemblystringLayer) -> Int { self.size }

pub fn BioseqassemblystringLayer::get(self : BioseqassemblystringLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringLayer::set(self : BioseqassemblystringLayer, i : Int, v : Double) -> BioseqassemblystringLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringLayer::sum(self : BioseqassemblystringLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringLayer::mean(self : BioseqassemblystringLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringLayer::scale(self : BioseqassemblystringLayer, f : Double) -> BioseqassemblystringLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringLayer::add(self : BioseqassemblystringLayer, other : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringLayer::copy(self : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringLayer::fill(self : BioseqassemblystringLayer, v : Double) -> BioseqassemblystringLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringLayer::min(self : BioseqassemblystringLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringLayer::max(self : BioseqassemblystringLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringLayer::to_string(self : BioseqassemblystringLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_buffer_make(size : Int) -> BioseqassemblystringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringBuffer::len(self : BioseqassemblystringBuffer) -> Int { self.size }

pub fn BioseqassemblystringBuffer::get(self : BioseqassemblystringBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringBuffer::set(self : BioseqassemblystringBuffer, i : Int, v : Double) -> BioseqassemblystringBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringBuffer::sum(self : BioseqassemblystringBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringBuffer::mean(self : BioseqassemblystringBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringBuffer::scale(self : BioseqassemblystringBuffer, f : Double) -> BioseqassemblystringBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringBuffer::add(self : BioseqassemblystringBuffer, other : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringBuffer::copy(self : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringBuffer::fill(self : BioseqassemblystringBuffer, v : Double) -> BioseqassemblystringBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringBuffer::min(self : BioseqassemblystringBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringBuffer::max(self : BioseqassemblystringBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringBuffer::to_string(self : BioseqassemblystringBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cursor_make(size : Int) -> BioseqassemblystringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringCursor::len(self : BioseqassemblystringCursor) -> Int { self.size }

pub fn BioseqassemblystringCursor::get(self : BioseqassemblystringCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringCursor::set(self : BioseqassemblystringCursor, i : Int, v : Double) -> BioseqassemblystringCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCursor::sum(self : BioseqassemblystringCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringCursor::mean(self : BioseqassemblystringCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringCursor::scale(self : BioseqassemblystringCursor, f : Double) -> BioseqassemblystringCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCursor::add(self : BioseqassemblystringCursor, other : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringCursor::copy(self : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCursor::fill(self : BioseqassemblystringCursor, v : Double) -> BioseqassemblystringCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringCursor::min(self : BioseqassemblystringCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringCursor::max(self : BioseqassemblystringCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringCursor::to_string(self : BioseqassemblystringCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_view_make(size : Int) -> BioseqassemblystringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringView::len(self : BioseqassemblystringView) -> Int { self.size }

pub fn BioseqassemblystringView::get(self : BioseqassemblystringView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringView::set(self : BioseqassemblystringView, i : Int, v : Double) -> BioseqassemblystringView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringView::sum(self : BioseqassemblystringView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringView::mean(self : BioseqassemblystringView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringView::scale(self : BioseqassemblystringView, f : Double) -> BioseqassemblystringView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringView::add(self : BioseqassemblystringView, other : BioseqassemblystringView) -> BioseqassemblystringView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringView::copy(self : BioseqassemblystringView) -> BioseqassemblystringView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringView::fill(self : BioseqassemblystringView, v : Double) -> BioseqassemblystringView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringView::min(self : BioseqassemblystringView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringView::max(self : BioseqassemblystringView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringView::to_string(self : BioseqassemblystringView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_range_make(size : Int) -> BioseqassemblystringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringRange::len(self : BioseqassemblystringRange) -> Int { self.size }

pub fn BioseqassemblystringRange::get(self : BioseqassemblystringRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringRange::set(self : BioseqassemblystringRange, i : Int, v : Double) -> BioseqassemblystringRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringRange::sum(self : BioseqassemblystringRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringRange::mean(self : BioseqassemblystringRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringRange::scale(self : BioseqassemblystringRange, f : Double) -> BioseqassemblystringRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringRange::add(self : BioseqassemblystringRange, other : BioseqassemblystringRange) -> BioseqassemblystringRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringRange::copy(self : BioseqassemblystringRange) -> BioseqassemblystringRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringRange::fill(self : BioseqassemblystringRange, v : Double) -> BioseqassemblystringRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringRange::min(self : BioseqassemblystringRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringRange::max(self : BioseqassemblystringRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringRange::to_string(self : BioseqassemblystringRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_slice_make(size : Int) -> BioseqassemblystringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblystringSlice::len(self : BioseqassemblystringSlice) -> Int { self.size }

pub fn BioseqassemblystringSlice::get(self : BioseqassemblystringSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblystringSlice::set(self : BioseqassemblystringSlice, i : Int, v : Double) -> BioseqassemblystringSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringSlice::sum(self : BioseqassemblystringSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblystringSlice::mean(self : BioseqassemblystringSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblystringSlice::scale(self : BioseqassemblystringSlice, f : Double) -> BioseqassemblystringSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringSlice::add(self : BioseqassemblystringSlice, other : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblystringSlice::copy(self : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringSlice::fill(self : BioseqassemblystringSlice, v : Double) -> BioseqassemblystringSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblystringSlice::min(self : BioseqassemblystringSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblystringSlice::max(self : BioseqassemblystringSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblystringSlice::to_string(self : BioseqassemblystringSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

