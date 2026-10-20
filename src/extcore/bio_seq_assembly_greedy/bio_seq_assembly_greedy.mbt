///===
/// extcore/bio_seq_assembly_greedy

pub(all) struct BioseqassemblygreedyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_greedy_make_point(x : Double, y : Double) -> BioseqassemblygreedyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_greedy_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygreedyPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblygreedyPoint::x(self : BioseqassemblygreedyPoint) -> Double { self.x }

pub fn BioseqassemblygreedyPoint::y(self : BioseqassemblygreedyPoint) -> Double { self.y }

pub fn BioseqassemblygreedyPoint::z(self : BioseqassemblygreedyPoint) -> Double { self.z }

pub fn BioseqassemblygreedyPoint::label(self : BioseqassemblygreedyPoint) -> Int { self.label }

pub fn BioseqassemblygreedyPoint::dist(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblygreedyPoint::add(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::sub(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::scale(self : BioseqassemblygreedyPoint, s : Double) -> BioseqassemblygreedyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblygreedyPoint::dot(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblygreedyPoint::cross(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblygreedyPoint::norm(self : BioseqassemblygreedyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblygreedyPoint::normalize(self : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygreedyPoint::negate(self : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::mid(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblygreedyPoint::lerp(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint, t : Double) -> BioseqassemblygreedyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblygreedyPoint::to_string(self : BioseqassemblygreedyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_greedy_make_series(vals : Array[Double], name : String) -> BioseqassemblygreedySeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblygreedySeries::len(self : BioseqassemblygreedySeries) -> Int { self.vals.length() }

pub fn BioseqassemblygreedySeries::sum(self : BioseqassemblygreedySeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblygreedySeries::mean(self : BioseqassemblygreedySeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblygreedySeries::min(self : BioseqassemblygreedySeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblygreedySeries::max(self : BioseqassemblygreedySeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblygreedySeries::range(self : BioseqassemblygreedySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblygreedySeries::variance(self : BioseqassemblygreedySeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblygreedySeries::std(self : BioseqassemblygreedySeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblygreedySeries::median(self : BioseqassemblygreedySeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblygreedySeries::scale(self : BioseqassemblygreedySeries, f : Double) -> BioseqassemblygreedySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::add(self : BioseqassemblygreedySeries, other : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::sub(self : BioseqassemblygreedySeries, other : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::normalize(self : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblygreedySeries::cumsum(self : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblygreedySeries::to_string(self : BioseqassemblygreedySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygreedyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_greedy_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygreedyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_greedy_matrix_identity(n : Int) -> BioseqassemblygreedyMatrix {
  let m = bio_seq_assembly_greedy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblygreedyMatrix::get(self : BioseqassemblygreedyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblygreedyMatrix::transpose(self : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblygreedyMatrix::add(self : BioseqassemblygreedyMatrix, other : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblygreedyMatrix::scale(self : BioseqassemblygreedyMatrix, s : Double) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblygreedyMatrix::multiply(self : BioseqassemblygreedyMatrix, other : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if self.cols != other.rows { return bio_seq_assembly_greedy_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblygreedyMatrix::trace(self : BioseqassemblygreedyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblygreedyMatrix::det(self : BioseqassemblygreedyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblygreedyMatrix::norm(self : BioseqassemblygreedyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblygreedyMatrix::to_string(self : BioseqassemblygreedyMatrix) -> String {
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

pub(all) struct BioseqassemblygreedyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_greedy_make_vector(comps : Array[Double]) -> BioseqassemblygreedyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_greedy_vector_zero(dim : Int) -> BioseqassemblygreedyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblygreedyVector::add(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygreedyVector::sub(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygreedyVector::scale(self : BioseqassemblygreedyVector, s : Double) -> BioseqassemblygreedyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblygreedyVector::dot(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblygreedyVector::norm(self : BioseqassemblygreedyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblygreedyVector::normalize(self : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygreedyVector::dist(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblygreedyVector::to_string(self : BioseqassemblygreedyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygreedyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_frame_make(size : Int) -> BioseqassemblygreedyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyFrame::len(self : BioseqassemblygreedyFrame) -> Int { self.size }

pub fn BioseqassemblygreedyFrame::get(self : BioseqassemblygreedyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyFrame::set(self : BioseqassemblygreedyFrame, i : Int, v : Double) -> BioseqassemblygreedyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyFrame::sum(self : BioseqassemblygreedyFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyFrame::mean(self : BioseqassemblygreedyFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyFrame::scale(self : BioseqassemblygreedyFrame, f : Double) -> BioseqassemblygreedyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyFrame::add(self : BioseqassemblygreedyFrame, other : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyFrame::copy(self : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyFrame::fill(self : BioseqassemblygreedyFrame, v : Double) -> BioseqassemblygreedyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyFrame::min(self : BioseqassemblygreedyFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyFrame::max(self : BioseqassemblygreedyFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyFrame::to_string(self : BioseqassemblygreedyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_table_make(size : Int) -> BioseqassemblygreedyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyTable::len(self : BioseqassemblygreedyTable) -> Int { self.size }

pub fn BioseqassemblygreedyTable::get(self : BioseqassemblygreedyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyTable::set(self : BioseqassemblygreedyTable, i : Int, v : Double) -> BioseqassemblygreedyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyTable::sum(self : BioseqassemblygreedyTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyTable::mean(self : BioseqassemblygreedyTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyTable::scale(self : BioseqassemblygreedyTable, f : Double) -> BioseqassemblygreedyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyTable::add(self : BioseqassemblygreedyTable, other : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyTable::copy(self : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyTable::fill(self : BioseqassemblygreedyTable, v : Double) -> BioseqassemblygreedyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyTable::min(self : BioseqassemblygreedyTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyTable::max(self : BioseqassemblygreedyTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyTable::to_string(self : BioseqassemblygreedyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_graphn_make(size : Int) -> BioseqassemblygreedyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyGraphN::len(self : BioseqassemblygreedyGraphN) -> Int { self.size }

pub fn BioseqassemblygreedyGraphN::get(self : BioseqassemblygreedyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyGraphN::set(self : BioseqassemblygreedyGraphN, i : Int, v : Double) -> BioseqassemblygreedyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyGraphN::sum(self : BioseqassemblygreedyGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyGraphN::mean(self : BioseqassemblygreedyGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyGraphN::scale(self : BioseqassemblygreedyGraphN, f : Double) -> BioseqassemblygreedyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyGraphN::add(self : BioseqassemblygreedyGraphN, other : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyGraphN::copy(self : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyGraphN::fill(self : BioseqassemblygreedyGraphN, v : Double) -> BioseqassemblygreedyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyGraphN::min(self : BioseqassemblygreedyGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyGraphN::max(self : BioseqassemblygreedyGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyGraphN::to_string(self : BioseqassemblygreedyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_node_make(size : Int) -> BioseqassemblygreedyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyNode::len(self : BioseqassemblygreedyNode) -> Int { self.size }

pub fn BioseqassemblygreedyNode::get(self : BioseqassemblygreedyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyNode::set(self : BioseqassemblygreedyNode, i : Int, v : Double) -> BioseqassemblygreedyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyNode::sum(self : BioseqassemblygreedyNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyNode::mean(self : BioseqassemblygreedyNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyNode::scale(self : BioseqassemblygreedyNode, f : Double) -> BioseqassemblygreedyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyNode::add(self : BioseqassemblygreedyNode, other : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyNode::copy(self : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyNode::fill(self : BioseqassemblygreedyNode, v : Double) -> BioseqassemblygreedyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyNode::min(self : BioseqassemblygreedyNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyNode::max(self : BioseqassemblygreedyNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyNode::to_string(self : BioseqassemblygreedyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_edge_make(size : Int) -> BioseqassemblygreedyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyEdge::len(self : BioseqassemblygreedyEdge) -> Int { self.size }

pub fn BioseqassemblygreedyEdge::get(self : BioseqassemblygreedyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyEdge::set(self : BioseqassemblygreedyEdge, i : Int, v : Double) -> BioseqassemblygreedyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyEdge::sum(self : BioseqassemblygreedyEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyEdge::mean(self : BioseqassemblygreedyEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyEdge::scale(self : BioseqassemblygreedyEdge, f : Double) -> BioseqassemblygreedyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyEdge::add(self : BioseqassemblygreedyEdge, other : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyEdge::copy(self : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyEdge::fill(self : BioseqassemblygreedyEdge, v : Double) -> BioseqassemblygreedyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyEdge::min(self : BioseqassemblygreedyEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyEdge::max(self : BioseqassemblygreedyEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyEdge::to_string(self : BioseqassemblygreedyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_path_make(size : Int) -> BioseqassemblygreedyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyPath::len(self : BioseqassemblygreedyPath) -> Int { self.size }

pub fn BioseqassemblygreedyPath::get(self : BioseqassemblygreedyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyPath::set(self : BioseqassemblygreedyPath, i : Int, v : Double) -> BioseqassemblygreedyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyPath::sum(self : BioseqassemblygreedyPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyPath::mean(self : BioseqassemblygreedyPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyPath::scale(self : BioseqassemblygreedyPath, f : Double) -> BioseqassemblygreedyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyPath::add(self : BioseqassemblygreedyPath, other : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyPath::copy(self : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyPath::fill(self : BioseqassemblygreedyPath, v : Double) -> BioseqassemblygreedyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyPath::min(self : BioseqassemblygreedyPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyPath::max(self : BioseqassemblygreedyPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyPath::to_string(self : BioseqassemblygreedyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cluster_make(size : Int) -> BioseqassemblygreedyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyCluster::len(self : BioseqassemblygreedyCluster) -> Int { self.size }

pub fn BioseqassemblygreedyCluster::get(self : BioseqassemblygreedyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyCluster::set(self : BioseqassemblygreedyCluster, i : Int, v : Double) -> BioseqassemblygreedyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCluster::sum(self : BioseqassemblygreedyCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyCluster::mean(self : BioseqassemblygreedyCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyCluster::scale(self : BioseqassemblygreedyCluster, f : Double) -> BioseqassemblygreedyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCluster::add(self : BioseqassemblygreedyCluster, other : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyCluster::copy(self : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCluster::fill(self : BioseqassemblygreedyCluster, v : Double) -> BioseqassemblygreedyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCluster::min(self : BioseqassemblygreedyCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyCluster::max(self : BioseqassemblygreedyCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyCluster::to_string(self : BioseqassemblygreedyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_model_make(size : Int) -> BioseqassemblygreedyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyModel::len(self : BioseqassemblygreedyModel) -> Int { self.size }

pub fn BioseqassemblygreedyModel::get(self : BioseqassemblygreedyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyModel::set(self : BioseqassemblygreedyModel, i : Int, v : Double) -> BioseqassemblygreedyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyModel::sum(self : BioseqassemblygreedyModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyModel::mean(self : BioseqassemblygreedyModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyModel::scale(self : BioseqassemblygreedyModel, f : Double) -> BioseqassemblygreedyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyModel::add(self : BioseqassemblygreedyModel, other : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyModel::copy(self : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyModel::fill(self : BioseqassemblygreedyModel, v : Double) -> BioseqassemblygreedyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyModel::min(self : BioseqassemblygreedyModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyModel::max(self : BioseqassemblygreedyModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyModel::to_string(self : BioseqassemblygreedyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_layer_make(size : Int) -> BioseqassemblygreedyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyLayer::len(self : BioseqassemblygreedyLayer) -> Int { self.size }

pub fn BioseqassemblygreedyLayer::get(self : BioseqassemblygreedyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyLayer::set(self : BioseqassemblygreedyLayer, i : Int, v : Double) -> BioseqassemblygreedyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyLayer::sum(self : BioseqassemblygreedyLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyLayer::mean(self : BioseqassemblygreedyLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyLayer::scale(self : BioseqassemblygreedyLayer, f : Double) -> BioseqassemblygreedyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyLayer::add(self : BioseqassemblygreedyLayer, other : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyLayer::copy(self : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyLayer::fill(self : BioseqassemblygreedyLayer, v : Double) -> BioseqassemblygreedyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyLayer::min(self : BioseqassemblygreedyLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyLayer::max(self : BioseqassemblygreedyLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyLayer::to_string(self : BioseqassemblygreedyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_buffer_make(size : Int) -> BioseqassemblygreedyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyBuffer::len(self : BioseqassemblygreedyBuffer) -> Int { self.size }

pub fn BioseqassemblygreedyBuffer::get(self : BioseqassemblygreedyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyBuffer::set(self : BioseqassemblygreedyBuffer, i : Int, v : Double) -> BioseqassemblygreedyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyBuffer::sum(self : BioseqassemblygreedyBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyBuffer::mean(self : BioseqassemblygreedyBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyBuffer::scale(self : BioseqassemblygreedyBuffer, f : Double) -> BioseqassemblygreedyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyBuffer::add(self : BioseqassemblygreedyBuffer, other : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyBuffer::copy(self : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyBuffer::fill(self : BioseqassemblygreedyBuffer, v : Double) -> BioseqassemblygreedyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyBuffer::min(self : BioseqassemblygreedyBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyBuffer::max(self : BioseqassemblygreedyBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyBuffer::to_string(self : BioseqassemblygreedyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cursor_make(size : Int) -> BioseqassemblygreedyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyCursor::len(self : BioseqassemblygreedyCursor) -> Int { self.size }

pub fn BioseqassemblygreedyCursor::get(self : BioseqassemblygreedyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyCursor::set(self : BioseqassemblygreedyCursor, i : Int, v : Double) -> BioseqassemblygreedyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCursor::sum(self : BioseqassemblygreedyCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyCursor::mean(self : BioseqassemblygreedyCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyCursor::scale(self : BioseqassemblygreedyCursor, f : Double) -> BioseqassemblygreedyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCursor::add(self : BioseqassemblygreedyCursor, other : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyCursor::copy(self : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCursor::fill(self : BioseqassemblygreedyCursor, v : Double) -> BioseqassemblygreedyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyCursor::min(self : BioseqassemblygreedyCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyCursor::max(self : BioseqassemblygreedyCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyCursor::to_string(self : BioseqassemblygreedyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_view_make(size : Int) -> BioseqassemblygreedyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyView::len(self : BioseqassemblygreedyView) -> Int { self.size }

pub fn BioseqassemblygreedyView::get(self : BioseqassemblygreedyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyView::set(self : BioseqassemblygreedyView, i : Int, v : Double) -> BioseqassemblygreedyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyView::sum(self : BioseqassemblygreedyView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyView::mean(self : BioseqassemblygreedyView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyView::scale(self : BioseqassemblygreedyView, f : Double) -> BioseqassemblygreedyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyView::add(self : BioseqassemblygreedyView, other : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyView::copy(self : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyView::fill(self : BioseqassemblygreedyView, v : Double) -> BioseqassemblygreedyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyView::min(self : BioseqassemblygreedyView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyView::max(self : BioseqassemblygreedyView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyView::to_string(self : BioseqassemblygreedyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_range_make(size : Int) -> BioseqassemblygreedyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedyRange::len(self : BioseqassemblygreedyRange) -> Int { self.size }

pub fn BioseqassemblygreedyRange::get(self : BioseqassemblygreedyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedyRange::set(self : BioseqassemblygreedyRange, i : Int, v : Double) -> BioseqassemblygreedyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyRange::sum(self : BioseqassemblygreedyRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedyRange::mean(self : BioseqassemblygreedyRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedyRange::scale(self : BioseqassemblygreedyRange, f : Double) -> BioseqassemblygreedyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyRange::add(self : BioseqassemblygreedyRange, other : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedyRange::copy(self : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyRange::fill(self : BioseqassemblygreedyRange, v : Double) -> BioseqassemblygreedyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedyRange::min(self : BioseqassemblygreedyRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedyRange::max(self : BioseqassemblygreedyRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedyRange::to_string(self : BioseqassemblygreedyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_slice_make(size : Int) -> BioseqassemblygreedySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygreedySlice::len(self : BioseqassemblygreedySlice) -> Int { self.size }

pub fn BioseqassemblygreedySlice::get(self : BioseqassemblygreedySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygreedySlice::set(self : BioseqassemblygreedySlice, i : Int, v : Double) -> BioseqassemblygreedySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedySlice::sum(self : BioseqassemblygreedySlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygreedySlice::mean(self : BioseqassemblygreedySlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygreedySlice::scale(self : BioseqassemblygreedySlice, f : Double) -> BioseqassemblygreedySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedySlice::add(self : BioseqassemblygreedySlice, other : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygreedySlice::copy(self : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedySlice::fill(self : BioseqassemblygreedySlice, v : Double) -> BioseqassemblygreedySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygreedySlice::min(self : BioseqassemblygreedySlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygreedySlice::max(self : BioseqassemblygreedySlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygreedySlice::to_string(self : BioseqassemblygreedySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

