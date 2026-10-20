///===
/// extcore/bio_seq_assembly_overlap

pub(all) struct BioseqassemblyoverlapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_overlap_make_point(x : Double, y : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_overlap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyoverlapPoint::x(self : BioseqassemblyoverlapPoint) -> Double { self.x }

pub fn BioseqassemblyoverlapPoint::y(self : BioseqassemblyoverlapPoint) -> Double { self.y }

pub fn BioseqassemblyoverlapPoint::z(self : BioseqassemblyoverlapPoint) -> Double { self.z }

pub fn BioseqassemblyoverlapPoint::label(self : BioseqassemblyoverlapPoint) -> Int { self.label }

pub fn BioseqassemblyoverlapPoint::dist(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyoverlapPoint::add(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::sub(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::scale(self : BioseqassemblyoverlapPoint, s : Double) -> BioseqassemblyoverlapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::dot(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyoverlapPoint::cross(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyoverlapPoint::norm(self : BioseqassemblyoverlapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyoverlapPoint::normalize(self : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyoverlapPoint::negate(self : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::mid(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::lerp(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint, t : Double) -> BioseqassemblyoverlapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::to_string(self : BioseqassemblyoverlapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_overlap_make_series(vals : Array[Double], name : String) -> BioseqassemblyoverlapSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyoverlapSeries::len(self : BioseqassemblyoverlapSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyoverlapSeries::sum(self : BioseqassemblyoverlapSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyoverlapSeries::mean(self : BioseqassemblyoverlapSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyoverlapSeries::min(self : BioseqassemblyoverlapSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyoverlapSeries::max(self : BioseqassemblyoverlapSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyoverlapSeries::range(self : BioseqassemblyoverlapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyoverlapSeries::variance(self : BioseqassemblyoverlapSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyoverlapSeries::std(self : BioseqassemblyoverlapSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyoverlapSeries::median(self : BioseqassemblyoverlapSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyoverlapSeries::scale(self : BioseqassemblyoverlapSeries, f : Double) -> BioseqassemblyoverlapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::add(self : BioseqassemblyoverlapSeries, other : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::sub(self : BioseqassemblyoverlapSeries, other : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::normalize(self : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyoverlapSeries::cumsum(self : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::to_string(self : BioseqassemblyoverlapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyoverlapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_overlap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyoverlapMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_overlap_matrix_identity(n : Int) -> BioseqassemblyoverlapMatrix {
  let m = bio_seq_assembly_overlap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyoverlapMatrix::get(self : BioseqassemblyoverlapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyoverlapMatrix::transpose(self : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyoverlapMatrix::add(self : BioseqassemblyoverlapMatrix, other : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyoverlapMatrix::scale(self : BioseqassemblyoverlapMatrix, s : Double) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyoverlapMatrix::multiply(self : BioseqassemblyoverlapMatrix, other : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if self.cols != other.rows { return bio_seq_assembly_overlap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblyoverlapMatrix::trace(self : BioseqassemblyoverlapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyoverlapMatrix::det(self : BioseqassemblyoverlapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyoverlapMatrix::norm(self : BioseqassemblyoverlapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyoverlapMatrix::to_string(self : BioseqassemblyoverlapMatrix) -> String {
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

pub(all) struct BioseqassemblyoverlapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_overlap_make_vector(comps : Array[Double]) -> BioseqassemblyoverlapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_overlap_vector_zero(dim : Int) -> BioseqassemblyoverlapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyoverlapVector::add(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyoverlapVector::sub(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyoverlapVector::scale(self : BioseqassemblyoverlapVector, s : Double) -> BioseqassemblyoverlapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyoverlapVector::dot(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyoverlapVector::norm(self : BioseqassemblyoverlapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyoverlapVector::normalize(self : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyoverlapVector::dist(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyoverlapVector::to_string(self : BioseqassemblyoverlapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyoverlapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_frame_make(size : Int) -> BioseqassemblyoverlapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapFrame::len(self : BioseqassemblyoverlapFrame) -> Int { self.size }

pub fn BioseqassemblyoverlapFrame::get(self : BioseqassemblyoverlapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapFrame::set(self : BioseqassemblyoverlapFrame, i : Int, v : Double) -> BioseqassemblyoverlapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapFrame::sum(self : BioseqassemblyoverlapFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapFrame::mean(self : BioseqassemblyoverlapFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapFrame::scale(self : BioseqassemblyoverlapFrame, f : Double) -> BioseqassemblyoverlapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapFrame::add(self : BioseqassemblyoverlapFrame, other : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapFrame::copy(self : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapFrame::fill(self : BioseqassemblyoverlapFrame, v : Double) -> BioseqassemblyoverlapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapFrame::min(self : BioseqassemblyoverlapFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapFrame::max(self : BioseqassemblyoverlapFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapFrame::to_string(self : BioseqassemblyoverlapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_table_make(size : Int) -> BioseqassemblyoverlapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapTable::len(self : BioseqassemblyoverlapTable) -> Int { self.size }

pub fn BioseqassemblyoverlapTable::get(self : BioseqassemblyoverlapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapTable::set(self : BioseqassemblyoverlapTable, i : Int, v : Double) -> BioseqassemblyoverlapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapTable::sum(self : BioseqassemblyoverlapTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapTable::mean(self : BioseqassemblyoverlapTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapTable::scale(self : BioseqassemblyoverlapTable, f : Double) -> BioseqassemblyoverlapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapTable::add(self : BioseqassemblyoverlapTable, other : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapTable::copy(self : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapTable::fill(self : BioseqassemblyoverlapTable, v : Double) -> BioseqassemblyoverlapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapTable::min(self : BioseqassemblyoverlapTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapTable::max(self : BioseqassemblyoverlapTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapTable::to_string(self : BioseqassemblyoverlapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_graphn_make(size : Int) -> BioseqassemblyoverlapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapGraphN::len(self : BioseqassemblyoverlapGraphN) -> Int { self.size }

pub fn BioseqassemblyoverlapGraphN::get(self : BioseqassemblyoverlapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapGraphN::set(self : BioseqassemblyoverlapGraphN, i : Int, v : Double) -> BioseqassemblyoverlapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapGraphN::sum(self : BioseqassemblyoverlapGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapGraphN::mean(self : BioseqassemblyoverlapGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapGraphN::scale(self : BioseqassemblyoverlapGraphN, f : Double) -> BioseqassemblyoverlapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapGraphN::add(self : BioseqassemblyoverlapGraphN, other : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapGraphN::copy(self : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapGraphN::fill(self : BioseqassemblyoverlapGraphN, v : Double) -> BioseqassemblyoverlapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapGraphN::min(self : BioseqassemblyoverlapGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapGraphN::max(self : BioseqassemblyoverlapGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapGraphN::to_string(self : BioseqassemblyoverlapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_node_make(size : Int) -> BioseqassemblyoverlapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapNode::len(self : BioseqassemblyoverlapNode) -> Int { self.size }

pub fn BioseqassemblyoverlapNode::get(self : BioseqassemblyoverlapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapNode::set(self : BioseqassemblyoverlapNode, i : Int, v : Double) -> BioseqassemblyoverlapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapNode::sum(self : BioseqassemblyoverlapNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapNode::mean(self : BioseqassemblyoverlapNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapNode::scale(self : BioseqassemblyoverlapNode, f : Double) -> BioseqassemblyoverlapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapNode::add(self : BioseqassemblyoverlapNode, other : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapNode::copy(self : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapNode::fill(self : BioseqassemblyoverlapNode, v : Double) -> BioseqassemblyoverlapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapNode::min(self : BioseqassemblyoverlapNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapNode::max(self : BioseqassemblyoverlapNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapNode::to_string(self : BioseqassemblyoverlapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_edge_make(size : Int) -> BioseqassemblyoverlapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapEdge::len(self : BioseqassemblyoverlapEdge) -> Int { self.size }

pub fn BioseqassemblyoverlapEdge::get(self : BioseqassemblyoverlapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapEdge::set(self : BioseqassemblyoverlapEdge, i : Int, v : Double) -> BioseqassemblyoverlapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapEdge::sum(self : BioseqassemblyoverlapEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapEdge::mean(self : BioseqassemblyoverlapEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapEdge::scale(self : BioseqassemblyoverlapEdge, f : Double) -> BioseqassemblyoverlapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapEdge::add(self : BioseqassemblyoverlapEdge, other : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapEdge::copy(self : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapEdge::fill(self : BioseqassemblyoverlapEdge, v : Double) -> BioseqassemblyoverlapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapEdge::min(self : BioseqassemblyoverlapEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapEdge::max(self : BioseqassemblyoverlapEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapEdge::to_string(self : BioseqassemblyoverlapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_path_make(size : Int) -> BioseqassemblyoverlapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapPath::len(self : BioseqassemblyoverlapPath) -> Int { self.size }

pub fn BioseqassemblyoverlapPath::get(self : BioseqassemblyoverlapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapPath::set(self : BioseqassemblyoverlapPath, i : Int, v : Double) -> BioseqassemblyoverlapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapPath::sum(self : BioseqassemblyoverlapPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapPath::mean(self : BioseqassemblyoverlapPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapPath::scale(self : BioseqassemblyoverlapPath, f : Double) -> BioseqassemblyoverlapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapPath::add(self : BioseqassemblyoverlapPath, other : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapPath::copy(self : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapPath::fill(self : BioseqassemblyoverlapPath, v : Double) -> BioseqassemblyoverlapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapPath::min(self : BioseqassemblyoverlapPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapPath::max(self : BioseqassemblyoverlapPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapPath::to_string(self : BioseqassemblyoverlapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cluster_make(size : Int) -> BioseqassemblyoverlapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapCluster::len(self : BioseqassemblyoverlapCluster) -> Int { self.size }

pub fn BioseqassemblyoverlapCluster::get(self : BioseqassemblyoverlapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapCluster::set(self : BioseqassemblyoverlapCluster, i : Int, v : Double) -> BioseqassemblyoverlapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCluster::sum(self : BioseqassemblyoverlapCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapCluster::mean(self : BioseqassemblyoverlapCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapCluster::scale(self : BioseqassemblyoverlapCluster, f : Double) -> BioseqassemblyoverlapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCluster::add(self : BioseqassemblyoverlapCluster, other : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapCluster::copy(self : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCluster::fill(self : BioseqassemblyoverlapCluster, v : Double) -> BioseqassemblyoverlapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCluster::min(self : BioseqassemblyoverlapCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapCluster::max(self : BioseqassemblyoverlapCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapCluster::to_string(self : BioseqassemblyoverlapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_model_make(size : Int) -> BioseqassemblyoverlapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapModel::len(self : BioseqassemblyoverlapModel) -> Int { self.size }

pub fn BioseqassemblyoverlapModel::get(self : BioseqassemblyoverlapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapModel::set(self : BioseqassemblyoverlapModel, i : Int, v : Double) -> BioseqassemblyoverlapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapModel::sum(self : BioseqassemblyoverlapModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapModel::mean(self : BioseqassemblyoverlapModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapModel::scale(self : BioseqassemblyoverlapModel, f : Double) -> BioseqassemblyoverlapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapModel::add(self : BioseqassemblyoverlapModel, other : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapModel::copy(self : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapModel::fill(self : BioseqassemblyoverlapModel, v : Double) -> BioseqassemblyoverlapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapModel::min(self : BioseqassemblyoverlapModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapModel::max(self : BioseqassemblyoverlapModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapModel::to_string(self : BioseqassemblyoverlapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_layer_make(size : Int) -> BioseqassemblyoverlapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapLayer::len(self : BioseqassemblyoverlapLayer) -> Int { self.size }

pub fn BioseqassemblyoverlapLayer::get(self : BioseqassemblyoverlapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapLayer::set(self : BioseqassemblyoverlapLayer, i : Int, v : Double) -> BioseqassemblyoverlapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapLayer::sum(self : BioseqassemblyoverlapLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapLayer::mean(self : BioseqassemblyoverlapLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapLayer::scale(self : BioseqassemblyoverlapLayer, f : Double) -> BioseqassemblyoverlapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapLayer::add(self : BioseqassemblyoverlapLayer, other : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapLayer::copy(self : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapLayer::fill(self : BioseqassemblyoverlapLayer, v : Double) -> BioseqassemblyoverlapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapLayer::min(self : BioseqassemblyoverlapLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapLayer::max(self : BioseqassemblyoverlapLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapLayer::to_string(self : BioseqassemblyoverlapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_buffer_make(size : Int) -> BioseqassemblyoverlapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapBuffer::len(self : BioseqassemblyoverlapBuffer) -> Int { self.size }

pub fn BioseqassemblyoverlapBuffer::get(self : BioseqassemblyoverlapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapBuffer::set(self : BioseqassemblyoverlapBuffer, i : Int, v : Double) -> BioseqassemblyoverlapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapBuffer::sum(self : BioseqassemblyoverlapBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapBuffer::mean(self : BioseqassemblyoverlapBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapBuffer::scale(self : BioseqassemblyoverlapBuffer, f : Double) -> BioseqassemblyoverlapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapBuffer::add(self : BioseqassemblyoverlapBuffer, other : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapBuffer::copy(self : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapBuffer::fill(self : BioseqassemblyoverlapBuffer, v : Double) -> BioseqassemblyoverlapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapBuffer::min(self : BioseqassemblyoverlapBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapBuffer::max(self : BioseqassemblyoverlapBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapBuffer::to_string(self : BioseqassemblyoverlapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cursor_make(size : Int) -> BioseqassemblyoverlapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapCursor::len(self : BioseqassemblyoverlapCursor) -> Int { self.size }

pub fn BioseqassemblyoverlapCursor::get(self : BioseqassemblyoverlapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapCursor::set(self : BioseqassemblyoverlapCursor, i : Int, v : Double) -> BioseqassemblyoverlapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCursor::sum(self : BioseqassemblyoverlapCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapCursor::mean(self : BioseqassemblyoverlapCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapCursor::scale(self : BioseqassemblyoverlapCursor, f : Double) -> BioseqassemblyoverlapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCursor::add(self : BioseqassemblyoverlapCursor, other : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapCursor::copy(self : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCursor::fill(self : BioseqassemblyoverlapCursor, v : Double) -> BioseqassemblyoverlapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapCursor::min(self : BioseqassemblyoverlapCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapCursor::max(self : BioseqassemblyoverlapCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapCursor::to_string(self : BioseqassemblyoverlapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_view_make(size : Int) -> BioseqassemblyoverlapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapView::len(self : BioseqassemblyoverlapView) -> Int { self.size }

pub fn BioseqassemblyoverlapView::get(self : BioseqassemblyoverlapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapView::set(self : BioseqassemblyoverlapView, i : Int, v : Double) -> BioseqassemblyoverlapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapView::sum(self : BioseqassemblyoverlapView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapView::mean(self : BioseqassemblyoverlapView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapView::scale(self : BioseqassemblyoverlapView, f : Double) -> BioseqassemblyoverlapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapView::add(self : BioseqassemblyoverlapView, other : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapView::copy(self : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapView::fill(self : BioseqassemblyoverlapView, v : Double) -> BioseqassemblyoverlapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapView::min(self : BioseqassemblyoverlapView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapView::max(self : BioseqassemblyoverlapView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapView::to_string(self : BioseqassemblyoverlapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_range_make(size : Int) -> BioseqassemblyoverlapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapRange::len(self : BioseqassemblyoverlapRange) -> Int { self.size }

pub fn BioseqassemblyoverlapRange::get(self : BioseqassemblyoverlapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapRange::set(self : BioseqassemblyoverlapRange, i : Int, v : Double) -> BioseqassemblyoverlapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapRange::sum(self : BioseqassemblyoverlapRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapRange::mean(self : BioseqassemblyoverlapRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapRange::scale(self : BioseqassemblyoverlapRange, f : Double) -> BioseqassemblyoverlapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapRange::add(self : BioseqassemblyoverlapRange, other : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapRange::copy(self : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapRange::fill(self : BioseqassemblyoverlapRange, v : Double) -> BioseqassemblyoverlapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapRange::min(self : BioseqassemblyoverlapRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapRange::max(self : BioseqassemblyoverlapRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapRange::to_string(self : BioseqassemblyoverlapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_slice_make(size : Int) -> BioseqassemblyoverlapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyoverlapSlice::len(self : BioseqassemblyoverlapSlice) -> Int { self.size }

pub fn BioseqassemblyoverlapSlice::get(self : BioseqassemblyoverlapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyoverlapSlice::set(self : BioseqassemblyoverlapSlice, i : Int, v : Double) -> BioseqassemblyoverlapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapSlice::sum(self : BioseqassemblyoverlapSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyoverlapSlice::mean(self : BioseqassemblyoverlapSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyoverlapSlice::scale(self : BioseqassemblyoverlapSlice, f : Double) -> BioseqassemblyoverlapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapSlice::add(self : BioseqassemblyoverlapSlice, other : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyoverlapSlice::copy(self : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapSlice::fill(self : BioseqassemblyoverlapSlice, v : Double) -> BioseqassemblyoverlapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyoverlapSlice::min(self : BioseqassemblyoverlapSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyoverlapSlice::max(self : BioseqassemblyoverlapSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyoverlapSlice::to_string(self : BioseqassemblyoverlapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

