///===
/// extcore/bio_seq_assembly_validate

pub(all) struct BioseqassemblyvalidatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_validate_make_point(x : Double, y : Double) -> BioseqassemblyvalidatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_validate_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyvalidatePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyvalidatePoint::x(self : BioseqassemblyvalidatePoint) -> Double { self.x }

pub fn BioseqassemblyvalidatePoint::y(self : BioseqassemblyvalidatePoint) -> Double { self.y }

pub fn BioseqassemblyvalidatePoint::z(self : BioseqassemblyvalidatePoint) -> Double { self.z }

pub fn BioseqassemblyvalidatePoint::label(self : BioseqassemblyvalidatePoint) -> Int { self.label }

pub fn BioseqassemblyvalidatePoint::dist(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyvalidatePoint::add(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::sub(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::scale(self : BioseqassemblyvalidatePoint, s : Double) -> BioseqassemblyvalidatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::dot(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyvalidatePoint::cross(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyvalidatePoint::norm(self : BioseqassemblyvalidatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyvalidatePoint::normalize(self : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyvalidatePoint::negate(self : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::mid(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::lerp(self : BioseqassemblyvalidatePoint, other : BioseqassemblyvalidatePoint, t : Double) -> BioseqassemblyvalidatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyvalidatePoint::to_string(self : BioseqassemblyvalidatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_validate_make_series(vals : Array[Double], name : String) -> BioseqassemblyvalidateSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyvalidateSeries::len(self : BioseqassemblyvalidateSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyvalidateSeries::sum(self : BioseqassemblyvalidateSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyvalidateSeries::mean(self : BioseqassemblyvalidateSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyvalidateSeries::min(self : BioseqassemblyvalidateSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyvalidateSeries::max(self : BioseqassemblyvalidateSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyvalidateSeries::range(self : BioseqassemblyvalidateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyvalidateSeries::variance(self : BioseqassemblyvalidateSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyvalidateSeries::std(self : BioseqassemblyvalidateSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyvalidateSeries::median(self : BioseqassemblyvalidateSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyvalidateSeries::scale(self : BioseqassemblyvalidateSeries, f : Double) -> BioseqassemblyvalidateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyvalidateSeries::add(self : BioseqassemblyvalidateSeries, other : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyvalidateSeries::sub(self : BioseqassemblyvalidateSeries, other : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyvalidateSeries::normalize(self : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyvalidateSeries::cumsum(self : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyvalidateSeries::to_string(self : BioseqassemblyvalidateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyvalidateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_validate_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyvalidateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_validate_matrix_identity(n : Int) -> BioseqassemblyvalidateMatrix {
  let m = bio_seq_assembly_validate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyvalidateMatrix::get(self : BioseqassemblyvalidateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyvalidateMatrix::transpose(self : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  let result = bio_seq_assembly_validate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyvalidateMatrix::add(self : BioseqassemblyvalidateMatrix, other : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_validate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyvalidateMatrix::scale(self : BioseqassemblyvalidateMatrix, s : Double) -> BioseqassemblyvalidateMatrix {
  let result = bio_seq_assembly_validate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyvalidateMatrix::multiply(self : BioseqassemblyvalidateMatrix, other : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  if self.cols != other.rows { return bio_seq_assembly_validate_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_validate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblyvalidateMatrix::trace(self : BioseqassemblyvalidateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyvalidateMatrix::det(self : BioseqassemblyvalidateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyvalidateMatrix::norm(self : BioseqassemblyvalidateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyvalidateMatrix::to_string(self : BioseqassemblyvalidateMatrix) -> String {
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

pub(all) struct BioseqassemblyvalidateVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_validate_make_vector(comps : Array[Double]) -> BioseqassemblyvalidateVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_validate_vector_zero(dim : Int) -> BioseqassemblyvalidateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyvalidateVector::add(self : BioseqassemblyvalidateVector, other : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyvalidateVector::sub(self : BioseqassemblyvalidateVector, other : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyvalidateVector::scale(self : BioseqassemblyvalidateVector, s : Double) -> BioseqassemblyvalidateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyvalidateVector::dot(self : BioseqassemblyvalidateVector, other : BioseqassemblyvalidateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyvalidateVector::norm(self : BioseqassemblyvalidateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyvalidateVector::normalize(self : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyvalidateVector::dist(self : BioseqassemblyvalidateVector, other : BioseqassemblyvalidateVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyvalidateVector::to_string(self : BioseqassemblyvalidateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyvalidateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_frame_make(size : Int) -> BioseqassemblyvalidateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateFrame::len(self : BioseqassemblyvalidateFrame) -> Int { self.size }

pub fn BioseqassemblyvalidateFrame::get(self : BioseqassemblyvalidateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateFrame::set(self : BioseqassemblyvalidateFrame, i : Int, v : Double) -> BioseqassemblyvalidateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateFrame::sum(self : BioseqassemblyvalidateFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateFrame::mean(self : BioseqassemblyvalidateFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateFrame::scale(self : BioseqassemblyvalidateFrame, f : Double) -> BioseqassemblyvalidateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateFrame::add(self : BioseqassemblyvalidateFrame, other : BioseqassemblyvalidateFrame) -> BioseqassemblyvalidateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateFrame::copy(self : BioseqassemblyvalidateFrame) -> BioseqassemblyvalidateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateFrame::fill(self : BioseqassemblyvalidateFrame, v : Double) -> BioseqassemblyvalidateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateFrame::min(self : BioseqassemblyvalidateFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateFrame::max(self : BioseqassemblyvalidateFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateFrame::to_string(self : BioseqassemblyvalidateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_table_make(size : Int) -> BioseqassemblyvalidateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateTable::len(self : BioseqassemblyvalidateTable) -> Int { self.size }

pub fn BioseqassemblyvalidateTable::get(self : BioseqassemblyvalidateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateTable::set(self : BioseqassemblyvalidateTable, i : Int, v : Double) -> BioseqassemblyvalidateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateTable::sum(self : BioseqassemblyvalidateTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateTable::mean(self : BioseqassemblyvalidateTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateTable::scale(self : BioseqassemblyvalidateTable, f : Double) -> BioseqassemblyvalidateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateTable::add(self : BioseqassemblyvalidateTable, other : BioseqassemblyvalidateTable) -> BioseqassemblyvalidateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateTable::copy(self : BioseqassemblyvalidateTable) -> BioseqassemblyvalidateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateTable::fill(self : BioseqassemblyvalidateTable, v : Double) -> BioseqassemblyvalidateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateTable::min(self : BioseqassemblyvalidateTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateTable::max(self : BioseqassemblyvalidateTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateTable::to_string(self : BioseqassemblyvalidateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_graphn_make(size : Int) -> BioseqassemblyvalidateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateGraphN::len(self : BioseqassemblyvalidateGraphN) -> Int { self.size }

pub fn BioseqassemblyvalidateGraphN::get(self : BioseqassemblyvalidateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateGraphN::set(self : BioseqassemblyvalidateGraphN, i : Int, v : Double) -> BioseqassemblyvalidateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateGraphN::sum(self : BioseqassemblyvalidateGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateGraphN::mean(self : BioseqassemblyvalidateGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateGraphN::scale(self : BioseqassemblyvalidateGraphN, f : Double) -> BioseqassemblyvalidateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateGraphN::add(self : BioseqassemblyvalidateGraphN, other : BioseqassemblyvalidateGraphN) -> BioseqassemblyvalidateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateGraphN::copy(self : BioseqassemblyvalidateGraphN) -> BioseqassemblyvalidateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateGraphN::fill(self : BioseqassemblyvalidateGraphN, v : Double) -> BioseqassemblyvalidateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateGraphN::min(self : BioseqassemblyvalidateGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateGraphN::max(self : BioseqassemblyvalidateGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateGraphN::to_string(self : BioseqassemblyvalidateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_node_make(size : Int) -> BioseqassemblyvalidateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateNode::len(self : BioseqassemblyvalidateNode) -> Int { self.size }

pub fn BioseqassemblyvalidateNode::get(self : BioseqassemblyvalidateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateNode::set(self : BioseqassemblyvalidateNode, i : Int, v : Double) -> BioseqassemblyvalidateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateNode::sum(self : BioseqassemblyvalidateNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateNode::mean(self : BioseqassemblyvalidateNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateNode::scale(self : BioseqassemblyvalidateNode, f : Double) -> BioseqassemblyvalidateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateNode::add(self : BioseqassemblyvalidateNode, other : BioseqassemblyvalidateNode) -> BioseqassemblyvalidateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateNode::copy(self : BioseqassemblyvalidateNode) -> BioseqassemblyvalidateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateNode::fill(self : BioseqassemblyvalidateNode, v : Double) -> BioseqassemblyvalidateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateNode::min(self : BioseqassemblyvalidateNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateNode::max(self : BioseqassemblyvalidateNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateNode::to_string(self : BioseqassemblyvalidateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_edge_make(size : Int) -> BioseqassemblyvalidateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateEdge::len(self : BioseqassemblyvalidateEdge) -> Int { self.size }

pub fn BioseqassemblyvalidateEdge::get(self : BioseqassemblyvalidateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateEdge::set(self : BioseqassemblyvalidateEdge, i : Int, v : Double) -> BioseqassemblyvalidateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateEdge::sum(self : BioseqassemblyvalidateEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateEdge::mean(self : BioseqassemblyvalidateEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateEdge::scale(self : BioseqassemblyvalidateEdge, f : Double) -> BioseqassemblyvalidateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateEdge::add(self : BioseqassemblyvalidateEdge, other : BioseqassemblyvalidateEdge) -> BioseqassemblyvalidateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateEdge::copy(self : BioseqassemblyvalidateEdge) -> BioseqassemblyvalidateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateEdge::fill(self : BioseqassemblyvalidateEdge, v : Double) -> BioseqassemblyvalidateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateEdge::min(self : BioseqassemblyvalidateEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateEdge::max(self : BioseqassemblyvalidateEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateEdge::to_string(self : BioseqassemblyvalidateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_path_make(size : Int) -> BioseqassemblyvalidatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidatePath::len(self : BioseqassemblyvalidatePath) -> Int { self.size }

pub fn BioseqassemblyvalidatePath::get(self : BioseqassemblyvalidatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidatePath::set(self : BioseqassemblyvalidatePath, i : Int, v : Double) -> BioseqassemblyvalidatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidatePath::sum(self : BioseqassemblyvalidatePath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidatePath::mean(self : BioseqassemblyvalidatePath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidatePath::scale(self : BioseqassemblyvalidatePath, f : Double) -> BioseqassemblyvalidatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidatePath::add(self : BioseqassemblyvalidatePath, other : BioseqassemblyvalidatePath) -> BioseqassemblyvalidatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidatePath::copy(self : BioseqassemblyvalidatePath) -> BioseqassemblyvalidatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidatePath::fill(self : BioseqassemblyvalidatePath, v : Double) -> BioseqassemblyvalidatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidatePath::min(self : BioseqassemblyvalidatePath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidatePath::max(self : BioseqassemblyvalidatePath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidatePath::to_string(self : BioseqassemblyvalidatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_cluster_make(size : Int) -> BioseqassemblyvalidateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateCluster::len(self : BioseqassemblyvalidateCluster) -> Int { self.size }

pub fn BioseqassemblyvalidateCluster::get(self : BioseqassemblyvalidateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateCluster::set(self : BioseqassemblyvalidateCluster, i : Int, v : Double) -> BioseqassemblyvalidateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCluster::sum(self : BioseqassemblyvalidateCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateCluster::mean(self : BioseqassemblyvalidateCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateCluster::scale(self : BioseqassemblyvalidateCluster, f : Double) -> BioseqassemblyvalidateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCluster::add(self : BioseqassemblyvalidateCluster, other : BioseqassemblyvalidateCluster) -> BioseqassemblyvalidateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateCluster::copy(self : BioseqassemblyvalidateCluster) -> BioseqassemblyvalidateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCluster::fill(self : BioseqassemblyvalidateCluster, v : Double) -> BioseqassemblyvalidateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCluster::min(self : BioseqassemblyvalidateCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateCluster::max(self : BioseqassemblyvalidateCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateCluster::to_string(self : BioseqassemblyvalidateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_model_make(size : Int) -> BioseqassemblyvalidateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateModel::len(self : BioseqassemblyvalidateModel) -> Int { self.size }

pub fn BioseqassemblyvalidateModel::get(self : BioseqassemblyvalidateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateModel::set(self : BioseqassemblyvalidateModel, i : Int, v : Double) -> BioseqassemblyvalidateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateModel::sum(self : BioseqassemblyvalidateModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateModel::mean(self : BioseqassemblyvalidateModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateModel::scale(self : BioseqassemblyvalidateModel, f : Double) -> BioseqassemblyvalidateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateModel::add(self : BioseqassemblyvalidateModel, other : BioseqassemblyvalidateModel) -> BioseqassemblyvalidateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateModel::copy(self : BioseqassemblyvalidateModel) -> BioseqassemblyvalidateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateModel::fill(self : BioseqassemblyvalidateModel, v : Double) -> BioseqassemblyvalidateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateModel::min(self : BioseqassemblyvalidateModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateModel::max(self : BioseqassemblyvalidateModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateModel::to_string(self : BioseqassemblyvalidateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_layer_make(size : Int) -> BioseqassemblyvalidateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateLayer::len(self : BioseqassemblyvalidateLayer) -> Int { self.size }

pub fn BioseqassemblyvalidateLayer::get(self : BioseqassemblyvalidateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateLayer::set(self : BioseqassemblyvalidateLayer, i : Int, v : Double) -> BioseqassemblyvalidateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateLayer::sum(self : BioseqassemblyvalidateLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateLayer::mean(self : BioseqassemblyvalidateLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateLayer::scale(self : BioseqassemblyvalidateLayer, f : Double) -> BioseqassemblyvalidateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateLayer::add(self : BioseqassemblyvalidateLayer, other : BioseqassemblyvalidateLayer) -> BioseqassemblyvalidateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateLayer::copy(self : BioseqassemblyvalidateLayer) -> BioseqassemblyvalidateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateLayer::fill(self : BioseqassemblyvalidateLayer, v : Double) -> BioseqassemblyvalidateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateLayer::min(self : BioseqassemblyvalidateLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateLayer::max(self : BioseqassemblyvalidateLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateLayer::to_string(self : BioseqassemblyvalidateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_buffer_make(size : Int) -> BioseqassemblyvalidateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateBuffer::len(self : BioseqassemblyvalidateBuffer) -> Int { self.size }

pub fn BioseqassemblyvalidateBuffer::get(self : BioseqassemblyvalidateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateBuffer::set(self : BioseqassemblyvalidateBuffer, i : Int, v : Double) -> BioseqassemblyvalidateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateBuffer::sum(self : BioseqassemblyvalidateBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateBuffer::mean(self : BioseqassemblyvalidateBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateBuffer::scale(self : BioseqassemblyvalidateBuffer, f : Double) -> BioseqassemblyvalidateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateBuffer::add(self : BioseqassemblyvalidateBuffer, other : BioseqassemblyvalidateBuffer) -> BioseqassemblyvalidateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateBuffer::copy(self : BioseqassemblyvalidateBuffer) -> BioseqassemblyvalidateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateBuffer::fill(self : BioseqassemblyvalidateBuffer, v : Double) -> BioseqassemblyvalidateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateBuffer::min(self : BioseqassemblyvalidateBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateBuffer::max(self : BioseqassemblyvalidateBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateBuffer::to_string(self : BioseqassemblyvalidateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_cursor_make(size : Int) -> BioseqassemblyvalidateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateCursor::len(self : BioseqassemblyvalidateCursor) -> Int { self.size }

pub fn BioseqassemblyvalidateCursor::get(self : BioseqassemblyvalidateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateCursor::set(self : BioseqassemblyvalidateCursor, i : Int, v : Double) -> BioseqassemblyvalidateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCursor::sum(self : BioseqassemblyvalidateCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateCursor::mean(self : BioseqassemblyvalidateCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateCursor::scale(self : BioseqassemblyvalidateCursor, f : Double) -> BioseqassemblyvalidateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCursor::add(self : BioseqassemblyvalidateCursor, other : BioseqassemblyvalidateCursor) -> BioseqassemblyvalidateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateCursor::copy(self : BioseqassemblyvalidateCursor) -> BioseqassemblyvalidateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCursor::fill(self : BioseqassemblyvalidateCursor, v : Double) -> BioseqassemblyvalidateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateCursor::min(self : BioseqassemblyvalidateCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateCursor::max(self : BioseqassemblyvalidateCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateCursor::to_string(self : BioseqassemblyvalidateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_view_make(size : Int) -> BioseqassemblyvalidateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateView::len(self : BioseqassemblyvalidateView) -> Int { self.size }

pub fn BioseqassemblyvalidateView::get(self : BioseqassemblyvalidateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateView::set(self : BioseqassemblyvalidateView, i : Int, v : Double) -> BioseqassemblyvalidateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateView::sum(self : BioseqassemblyvalidateView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateView::mean(self : BioseqassemblyvalidateView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateView::scale(self : BioseqassemblyvalidateView, f : Double) -> BioseqassemblyvalidateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateView::add(self : BioseqassemblyvalidateView, other : BioseqassemblyvalidateView) -> BioseqassemblyvalidateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateView::copy(self : BioseqassemblyvalidateView) -> BioseqassemblyvalidateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateView::fill(self : BioseqassemblyvalidateView, v : Double) -> BioseqassemblyvalidateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateView::min(self : BioseqassemblyvalidateView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateView::max(self : BioseqassemblyvalidateView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateView::to_string(self : BioseqassemblyvalidateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_range_make(size : Int) -> BioseqassemblyvalidateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateRange::len(self : BioseqassemblyvalidateRange) -> Int { self.size }

pub fn BioseqassemblyvalidateRange::get(self : BioseqassemblyvalidateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateRange::set(self : BioseqassemblyvalidateRange, i : Int, v : Double) -> BioseqassemblyvalidateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateRange::sum(self : BioseqassemblyvalidateRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateRange::mean(self : BioseqassemblyvalidateRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateRange::scale(self : BioseqassemblyvalidateRange, f : Double) -> BioseqassemblyvalidateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateRange::add(self : BioseqassemblyvalidateRange, other : BioseqassemblyvalidateRange) -> BioseqassemblyvalidateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateRange::copy(self : BioseqassemblyvalidateRange) -> BioseqassemblyvalidateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateRange::fill(self : BioseqassemblyvalidateRange, v : Double) -> BioseqassemblyvalidateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateRange::min(self : BioseqassemblyvalidateRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateRange::max(self : BioseqassemblyvalidateRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateRange::to_string(self : BioseqassemblyvalidateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_slice_make(size : Int) -> BioseqassemblyvalidateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyvalidateSlice::len(self : BioseqassemblyvalidateSlice) -> Int { self.size }

pub fn BioseqassemblyvalidateSlice::get(self : BioseqassemblyvalidateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyvalidateSlice::set(self : BioseqassemblyvalidateSlice, i : Int, v : Double) -> BioseqassemblyvalidateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateSlice::sum(self : BioseqassemblyvalidateSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyvalidateSlice::mean(self : BioseqassemblyvalidateSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyvalidateSlice::scale(self : BioseqassemblyvalidateSlice, f : Double) -> BioseqassemblyvalidateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateSlice::add(self : BioseqassemblyvalidateSlice, other : BioseqassemblyvalidateSlice) -> BioseqassemblyvalidateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyvalidateSlice::copy(self : BioseqassemblyvalidateSlice) -> BioseqassemblyvalidateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateSlice::fill(self : BioseqassemblyvalidateSlice, v : Double) -> BioseqassemblyvalidateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyvalidateSlice::min(self : BioseqassemblyvalidateSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyvalidateSlice::max(self : BioseqassemblyvalidateSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyvalidateSlice::to_string(self : BioseqassemblyvalidateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

