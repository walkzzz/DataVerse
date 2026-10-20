///===
/// extcore/bio_seq_assembly_gap

pub(all) struct BioseqassemblygapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_gap_make_point(x : Double, y : Double) -> BioseqassemblygapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_gap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygapPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblygapPoint::x(self : BioseqassemblygapPoint) -> Double { self.x }

pub fn BioseqassemblygapPoint::y(self : BioseqassemblygapPoint) -> Double { self.y }

pub fn BioseqassemblygapPoint::z(self : BioseqassemblygapPoint) -> Double { self.z }

pub fn BioseqassemblygapPoint::label(self : BioseqassemblygapPoint) -> Int { self.label }

pub fn BioseqassemblygapPoint::dist(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblygapPoint::add(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblygapPoint::sub(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblygapPoint::scale(self : BioseqassemblygapPoint, s : Double) -> BioseqassemblygapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblygapPoint::dot(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblygapPoint::cross(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblygapPoint::norm(self : BioseqassemblygapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblygapPoint::normalize(self : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygapPoint::negate(self : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblygapPoint::mid(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblygapPoint::lerp(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint, t : Double) -> BioseqassemblygapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblygapPoint::to_string(self : BioseqassemblygapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblygapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_gap_make_series(vals : Array[Double], name : String) -> BioseqassemblygapSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblygapSeries::len(self : BioseqassemblygapSeries) -> Int { self.vals.length() }

pub fn BioseqassemblygapSeries::sum(self : BioseqassemblygapSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblygapSeries::mean(self : BioseqassemblygapSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblygapSeries::min(self : BioseqassemblygapSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblygapSeries::max(self : BioseqassemblygapSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblygapSeries::range(self : BioseqassemblygapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblygapSeries::variance(self : BioseqassemblygapSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblygapSeries::std(self : BioseqassemblygapSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblygapSeries::median(self : BioseqassemblygapSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblygapSeries::scale(self : BioseqassemblygapSeries, f : Double) -> BioseqassemblygapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::add(self : BioseqassemblygapSeries, other : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::sub(self : BioseqassemblygapSeries, other : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::normalize(self : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblygapSeries::cumsum(self : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblygapSeries::to_string(self : BioseqassemblygapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_gap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_gap_matrix_identity(n : Int) -> BioseqassemblygapMatrix {
  let m = bio_seq_assembly_gap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblygapMatrix::get(self : BioseqassemblygapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblygapMatrix::transpose(self : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblygapMatrix::add(self : BioseqassemblygapMatrix, other : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_gap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblygapMatrix::scale(self : BioseqassemblygapMatrix, s : Double) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblygapMatrix::multiply(self : BioseqassemblygapMatrix, other : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if self.cols != other.rows { return bio_seq_assembly_gap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_gap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblygapMatrix::trace(self : BioseqassemblygapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblygapMatrix::det(self : BioseqassemblygapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblygapMatrix::norm(self : BioseqassemblygapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblygapMatrix::to_string(self : BioseqassemblygapMatrix) -> String {
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

pub(all) struct BioseqassemblygapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_gap_make_vector(comps : Array[Double]) -> BioseqassemblygapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_gap_vector_zero(dim : Int) -> BioseqassemblygapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblygapVector::add(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygapVector::sub(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygapVector::scale(self : BioseqassemblygapVector, s : Double) -> BioseqassemblygapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblygapVector::dot(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblygapVector::norm(self : BioseqassemblygapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblygapVector::normalize(self : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygapVector::dist(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblygapVector::to_string(self : BioseqassemblygapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_frame_make(size : Int) -> BioseqassemblygapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapFrame::len(self : BioseqassemblygapFrame) -> Int { self.size }

pub fn BioseqassemblygapFrame::get(self : BioseqassemblygapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapFrame::set(self : BioseqassemblygapFrame, i : Int, v : Double) -> BioseqassemblygapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapFrame::sum(self : BioseqassemblygapFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapFrame::mean(self : BioseqassemblygapFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapFrame::scale(self : BioseqassemblygapFrame, f : Double) -> BioseqassemblygapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapFrame::add(self : BioseqassemblygapFrame, other : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapFrame::copy(self : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapFrame::fill(self : BioseqassemblygapFrame, v : Double) -> BioseqassemblygapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapFrame::min(self : BioseqassemblygapFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapFrame::max(self : BioseqassemblygapFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapFrame::to_string(self : BioseqassemblygapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_table_make(size : Int) -> BioseqassemblygapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapTable::len(self : BioseqassemblygapTable) -> Int { self.size }

pub fn BioseqassemblygapTable::get(self : BioseqassemblygapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapTable::set(self : BioseqassemblygapTable, i : Int, v : Double) -> BioseqassemblygapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapTable::sum(self : BioseqassemblygapTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapTable::mean(self : BioseqassemblygapTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapTable::scale(self : BioseqassemblygapTable, f : Double) -> BioseqassemblygapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapTable::add(self : BioseqassemblygapTable, other : BioseqassemblygapTable) -> BioseqassemblygapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapTable::copy(self : BioseqassemblygapTable) -> BioseqassemblygapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapTable::fill(self : BioseqassemblygapTable, v : Double) -> BioseqassemblygapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapTable::min(self : BioseqassemblygapTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapTable::max(self : BioseqassemblygapTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapTable::to_string(self : BioseqassemblygapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_graphn_make(size : Int) -> BioseqassemblygapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapGraphN::len(self : BioseqassemblygapGraphN) -> Int { self.size }

pub fn BioseqassemblygapGraphN::get(self : BioseqassemblygapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapGraphN::set(self : BioseqassemblygapGraphN, i : Int, v : Double) -> BioseqassemblygapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapGraphN::sum(self : BioseqassemblygapGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapGraphN::mean(self : BioseqassemblygapGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapGraphN::scale(self : BioseqassemblygapGraphN, f : Double) -> BioseqassemblygapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapGraphN::add(self : BioseqassemblygapGraphN, other : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapGraphN::copy(self : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapGraphN::fill(self : BioseqassemblygapGraphN, v : Double) -> BioseqassemblygapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapGraphN::min(self : BioseqassemblygapGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapGraphN::max(self : BioseqassemblygapGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapGraphN::to_string(self : BioseqassemblygapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_node_make(size : Int) -> BioseqassemblygapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapNode::len(self : BioseqassemblygapNode) -> Int { self.size }

pub fn BioseqassemblygapNode::get(self : BioseqassemblygapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapNode::set(self : BioseqassemblygapNode, i : Int, v : Double) -> BioseqassemblygapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapNode::sum(self : BioseqassemblygapNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapNode::mean(self : BioseqassemblygapNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapNode::scale(self : BioseqassemblygapNode, f : Double) -> BioseqassemblygapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapNode::add(self : BioseqassemblygapNode, other : BioseqassemblygapNode) -> BioseqassemblygapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapNode::copy(self : BioseqassemblygapNode) -> BioseqassemblygapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapNode::fill(self : BioseqassemblygapNode, v : Double) -> BioseqassemblygapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapNode::min(self : BioseqassemblygapNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapNode::max(self : BioseqassemblygapNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapNode::to_string(self : BioseqassemblygapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_edge_make(size : Int) -> BioseqassemblygapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapEdge::len(self : BioseqassemblygapEdge) -> Int { self.size }

pub fn BioseqassemblygapEdge::get(self : BioseqassemblygapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapEdge::set(self : BioseqassemblygapEdge, i : Int, v : Double) -> BioseqassemblygapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapEdge::sum(self : BioseqassemblygapEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapEdge::mean(self : BioseqassemblygapEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapEdge::scale(self : BioseqassemblygapEdge, f : Double) -> BioseqassemblygapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapEdge::add(self : BioseqassemblygapEdge, other : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapEdge::copy(self : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapEdge::fill(self : BioseqassemblygapEdge, v : Double) -> BioseqassemblygapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapEdge::min(self : BioseqassemblygapEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapEdge::max(self : BioseqassemblygapEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapEdge::to_string(self : BioseqassemblygapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_path_make(size : Int) -> BioseqassemblygapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapPath::len(self : BioseqassemblygapPath) -> Int { self.size }

pub fn BioseqassemblygapPath::get(self : BioseqassemblygapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapPath::set(self : BioseqassemblygapPath, i : Int, v : Double) -> BioseqassemblygapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapPath::sum(self : BioseqassemblygapPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapPath::mean(self : BioseqassemblygapPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapPath::scale(self : BioseqassemblygapPath, f : Double) -> BioseqassemblygapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapPath::add(self : BioseqassemblygapPath, other : BioseqassemblygapPath) -> BioseqassemblygapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapPath::copy(self : BioseqassemblygapPath) -> BioseqassemblygapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapPath::fill(self : BioseqassemblygapPath, v : Double) -> BioseqassemblygapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapPath::min(self : BioseqassemblygapPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapPath::max(self : BioseqassemblygapPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapPath::to_string(self : BioseqassemblygapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cluster_make(size : Int) -> BioseqassemblygapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapCluster::len(self : BioseqassemblygapCluster) -> Int { self.size }

pub fn BioseqassemblygapCluster::get(self : BioseqassemblygapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapCluster::set(self : BioseqassemblygapCluster, i : Int, v : Double) -> BioseqassemblygapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCluster::sum(self : BioseqassemblygapCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapCluster::mean(self : BioseqassemblygapCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapCluster::scale(self : BioseqassemblygapCluster, f : Double) -> BioseqassemblygapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCluster::add(self : BioseqassemblygapCluster, other : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapCluster::copy(self : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCluster::fill(self : BioseqassemblygapCluster, v : Double) -> BioseqassemblygapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCluster::min(self : BioseqassemblygapCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapCluster::max(self : BioseqassemblygapCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapCluster::to_string(self : BioseqassemblygapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_model_make(size : Int) -> BioseqassemblygapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapModel::len(self : BioseqassemblygapModel) -> Int { self.size }

pub fn BioseqassemblygapModel::get(self : BioseqassemblygapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapModel::set(self : BioseqassemblygapModel, i : Int, v : Double) -> BioseqassemblygapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapModel::sum(self : BioseqassemblygapModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapModel::mean(self : BioseqassemblygapModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapModel::scale(self : BioseqassemblygapModel, f : Double) -> BioseqassemblygapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapModel::add(self : BioseqassemblygapModel, other : BioseqassemblygapModel) -> BioseqassemblygapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapModel::copy(self : BioseqassemblygapModel) -> BioseqassemblygapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapModel::fill(self : BioseqassemblygapModel, v : Double) -> BioseqassemblygapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapModel::min(self : BioseqassemblygapModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapModel::max(self : BioseqassemblygapModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapModel::to_string(self : BioseqassemblygapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_layer_make(size : Int) -> BioseqassemblygapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapLayer::len(self : BioseqassemblygapLayer) -> Int { self.size }

pub fn BioseqassemblygapLayer::get(self : BioseqassemblygapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapLayer::set(self : BioseqassemblygapLayer, i : Int, v : Double) -> BioseqassemblygapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapLayer::sum(self : BioseqassemblygapLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapLayer::mean(self : BioseqassemblygapLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapLayer::scale(self : BioseqassemblygapLayer, f : Double) -> BioseqassemblygapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapLayer::add(self : BioseqassemblygapLayer, other : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapLayer::copy(self : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapLayer::fill(self : BioseqassemblygapLayer, v : Double) -> BioseqassemblygapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapLayer::min(self : BioseqassemblygapLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapLayer::max(self : BioseqassemblygapLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapLayer::to_string(self : BioseqassemblygapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_buffer_make(size : Int) -> BioseqassemblygapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapBuffer::len(self : BioseqassemblygapBuffer) -> Int { self.size }

pub fn BioseqassemblygapBuffer::get(self : BioseqassemblygapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapBuffer::set(self : BioseqassemblygapBuffer, i : Int, v : Double) -> BioseqassemblygapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapBuffer::sum(self : BioseqassemblygapBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapBuffer::mean(self : BioseqassemblygapBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapBuffer::scale(self : BioseqassemblygapBuffer, f : Double) -> BioseqassemblygapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapBuffer::add(self : BioseqassemblygapBuffer, other : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapBuffer::copy(self : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapBuffer::fill(self : BioseqassemblygapBuffer, v : Double) -> BioseqassemblygapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapBuffer::min(self : BioseqassemblygapBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapBuffer::max(self : BioseqassemblygapBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapBuffer::to_string(self : BioseqassemblygapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cursor_make(size : Int) -> BioseqassemblygapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapCursor::len(self : BioseqassemblygapCursor) -> Int { self.size }

pub fn BioseqassemblygapCursor::get(self : BioseqassemblygapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapCursor::set(self : BioseqassemblygapCursor, i : Int, v : Double) -> BioseqassemblygapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCursor::sum(self : BioseqassemblygapCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapCursor::mean(self : BioseqassemblygapCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapCursor::scale(self : BioseqassemblygapCursor, f : Double) -> BioseqassemblygapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCursor::add(self : BioseqassemblygapCursor, other : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapCursor::copy(self : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCursor::fill(self : BioseqassemblygapCursor, v : Double) -> BioseqassemblygapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapCursor::min(self : BioseqassemblygapCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapCursor::max(self : BioseqassemblygapCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapCursor::to_string(self : BioseqassemblygapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_view_make(size : Int) -> BioseqassemblygapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapView::len(self : BioseqassemblygapView) -> Int { self.size }

pub fn BioseqassemblygapView::get(self : BioseqassemblygapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapView::set(self : BioseqassemblygapView, i : Int, v : Double) -> BioseqassemblygapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapView::sum(self : BioseqassemblygapView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapView::mean(self : BioseqassemblygapView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapView::scale(self : BioseqassemblygapView, f : Double) -> BioseqassemblygapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapView::add(self : BioseqassemblygapView, other : BioseqassemblygapView) -> BioseqassemblygapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapView::copy(self : BioseqassemblygapView) -> BioseqassemblygapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapView::fill(self : BioseqassemblygapView, v : Double) -> BioseqassemblygapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapView::min(self : BioseqassemblygapView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapView::max(self : BioseqassemblygapView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapView::to_string(self : BioseqassemblygapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_range_make(size : Int) -> BioseqassemblygapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapRange::len(self : BioseqassemblygapRange) -> Int { self.size }

pub fn BioseqassemblygapRange::get(self : BioseqassemblygapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapRange::set(self : BioseqassemblygapRange, i : Int, v : Double) -> BioseqassemblygapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapRange::sum(self : BioseqassemblygapRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapRange::mean(self : BioseqassemblygapRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapRange::scale(self : BioseqassemblygapRange, f : Double) -> BioseqassemblygapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapRange::add(self : BioseqassemblygapRange, other : BioseqassemblygapRange) -> BioseqassemblygapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapRange::copy(self : BioseqassemblygapRange) -> BioseqassemblygapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapRange::fill(self : BioseqassemblygapRange, v : Double) -> BioseqassemblygapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapRange::min(self : BioseqassemblygapRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapRange::max(self : BioseqassemblygapRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapRange::to_string(self : BioseqassemblygapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_slice_make(size : Int) -> BioseqassemblygapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblygapSlice::len(self : BioseqassemblygapSlice) -> Int { self.size }

pub fn BioseqassemblygapSlice::get(self : BioseqassemblygapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblygapSlice::set(self : BioseqassemblygapSlice, i : Int, v : Double) -> BioseqassemblygapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapSlice::sum(self : BioseqassemblygapSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblygapSlice::mean(self : BioseqassemblygapSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblygapSlice::scale(self : BioseqassemblygapSlice, f : Double) -> BioseqassemblygapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapSlice::add(self : BioseqassemblygapSlice, other : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblygapSlice::copy(self : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapSlice::fill(self : BioseqassemblygapSlice, v : Double) -> BioseqassemblygapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblygapSlice::min(self : BioseqassemblygapSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblygapSlice::max(self : BioseqassemblygapSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblygapSlice::to_string(self : BioseqassemblygapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

