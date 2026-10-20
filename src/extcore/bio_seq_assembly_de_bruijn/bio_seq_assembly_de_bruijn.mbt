///===
/// extcore/bio_seq_assembly_de_bruijn

pub(all) struct BioseqassemblydebruijnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_de_bruijn_make_point(x : Double, y : Double) -> BioseqassemblydebruijnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_de_bruijn_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblydebruijnPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblydebruijnPoint::x(self : BioseqassemblydebruijnPoint) -> Double { self.x }

pub fn BioseqassemblydebruijnPoint::y(self : BioseqassemblydebruijnPoint) -> Double { self.y }

pub fn BioseqassemblydebruijnPoint::z(self : BioseqassemblydebruijnPoint) -> Double { self.z }

pub fn BioseqassemblydebruijnPoint::label(self : BioseqassemblydebruijnPoint) -> Int { self.label }

pub fn BioseqassemblydebruijnPoint::dist(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblydebruijnPoint::add(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::sub(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::scale(self : BioseqassemblydebruijnPoint, s : Double) -> BioseqassemblydebruijnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::dot(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblydebruijnPoint::cross(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblydebruijnPoint::norm(self : BioseqassemblydebruijnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblydebruijnPoint::normalize(self : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblydebruijnPoint::negate(self : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::mid(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::lerp(self : BioseqassemblydebruijnPoint, other : BioseqassemblydebruijnPoint, t : Double) -> BioseqassemblydebruijnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblydebruijnPoint::to_string(self : BioseqassemblydebruijnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_de_bruijn_make_series(vals : Array[Double], name : String) -> BioseqassemblydebruijnSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblydebruijnSeries::len(self : BioseqassemblydebruijnSeries) -> Int { self.vals.length() }

pub fn BioseqassemblydebruijnSeries::sum(self : BioseqassemblydebruijnSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblydebruijnSeries::mean(self : BioseqassemblydebruijnSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblydebruijnSeries::min(self : BioseqassemblydebruijnSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblydebruijnSeries::max(self : BioseqassemblydebruijnSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblydebruijnSeries::range(self : BioseqassemblydebruijnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblydebruijnSeries::variance(self : BioseqassemblydebruijnSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblydebruijnSeries::std(self : BioseqassemblydebruijnSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblydebruijnSeries::median(self : BioseqassemblydebruijnSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblydebruijnSeries::scale(self : BioseqassemblydebruijnSeries, f : Double) -> BioseqassemblydebruijnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblydebruijnSeries::add(self : BioseqassemblydebruijnSeries, other : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblydebruijnSeries::sub(self : BioseqassemblydebruijnSeries, other : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblydebruijnSeries::normalize(self : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblydebruijnSeries::cumsum(self : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblydebruijnSeries::to_string(self : BioseqassemblydebruijnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblydebruijnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_de_bruijn_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblydebruijnMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_de_bruijn_matrix_identity(n : Int) -> BioseqassemblydebruijnMatrix {
  let m = bio_seq_assembly_de_bruijn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblydebruijnMatrix::get(self : BioseqassemblydebruijnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblydebruijnMatrix::transpose(self : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  let result = bio_seq_assembly_de_bruijn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblydebruijnMatrix::add(self : BioseqassemblydebruijnMatrix, other : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_de_bruijn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblydebruijnMatrix::scale(self : BioseqassemblydebruijnMatrix, s : Double) -> BioseqassemblydebruijnMatrix {
  let result = bio_seq_assembly_de_bruijn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblydebruijnMatrix::multiply(self : BioseqassemblydebruijnMatrix, other : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  if self.cols != other.rows { return bio_seq_assembly_de_bruijn_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_de_bruijn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblydebruijnMatrix::trace(self : BioseqassemblydebruijnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblydebruijnMatrix::det(self : BioseqassemblydebruijnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblydebruijnMatrix::norm(self : BioseqassemblydebruijnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblydebruijnMatrix::to_string(self : BioseqassemblydebruijnMatrix) -> String {
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

pub(all) struct BioseqassemblydebruijnVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_de_bruijn_make_vector(comps : Array[Double]) -> BioseqassemblydebruijnVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_de_bruijn_vector_zero(dim : Int) -> BioseqassemblydebruijnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblydebruijnVector::add(self : BioseqassemblydebruijnVector, other : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblydebruijnVector::sub(self : BioseqassemblydebruijnVector, other : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblydebruijnVector::scale(self : BioseqassemblydebruijnVector, s : Double) -> BioseqassemblydebruijnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblydebruijnVector::dot(self : BioseqassemblydebruijnVector, other : BioseqassemblydebruijnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblydebruijnVector::norm(self : BioseqassemblydebruijnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblydebruijnVector::normalize(self : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblydebruijnVector::dist(self : BioseqassemblydebruijnVector, other : BioseqassemblydebruijnVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblydebruijnVector::to_string(self : BioseqassemblydebruijnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblydebruijnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_frame_make(size : Int) -> BioseqassemblydebruijnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnFrame::len(self : BioseqassemblydebruijnFrame) -> Int { self.size }

pub fn BioseqassemblydebruijnFrame::get(self : BioseqassemblydebruijnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnFrame::set(self : BioseqassemblydebruijnFrame, i : Int, v : Double) -> BioseqassemblydebruijnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnFrame::sum(self : BioseqassemblydebruijnFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnFrame::mean(self : BioseqassemblydebruijnFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnFrame::scale(self : BioseqassemblydebruijnFrame, f : Double) -> BioseqassemblydebruijnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnFrame::add(self : BioseqassemblydebruijnFrame, other : BioseqassemblydebruijnFrame) -> BioseqassemblydebruijnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnFrame::copy(self : BioseqassemblydebruijnFrame) -> BioseqassemblydebruijnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnFrame::fill(self : BioseqassemblydebruijnFrame, v : Double) -> BioseqassemblydebruijnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnFrame::min(self : BioseqassemblydebruijnFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnFrame::max(self : BioseqassemblydebruijnFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnFrame::to_string(self : BioseqassemblydebruijnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_table_make(size : Int) -> BioseqassemblydebruijnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnTable::len(self : BioseqassemblydebruijnTable) -> Int { self.size }

pub fn BioseqassemblydebruijnTable::get(self : BioseqassemblydebruijnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnTable::set(self : BioseqassemblydebruijnTable, i : Int, v : Double) -> BioseqassemblydebruijnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnTable::sum(self : BioseqassemblydebruijnTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnTable::mean(self : BioseqassemblydebruijnTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnTable::scale(self : BioseqassemblydebruijnTable, f : Double) -> BioseqassemblydebruijnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnTable::add(self : BioseqassemblydebruijnTable, other : BioseqassemblydebruijnTable) -> BioseqassemblydebruijnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnTable::copy(self : BioseqassemblydebruijnTable) -> BioseqassemblydebruijnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnTable::fill(self : BioseqassemblydebruijnTable, v : Double) -> BioseqassemblydebruijnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnTable::min(self : BioseqassemblydebruijnTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnTable::max(self : BioseqassemblydebruijnTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnTable::to_string(self : BioseqassemblydebruijnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_graphn_make(size : Int) -> BioseqassemblydebruijnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnGraphN::len(self : BioseqassemblydebruijnGraphN) -> Int { self.size }

pub fn BioseqassemblydebruijnGraphN::get(self : BioseqassemblydebruijnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnGraphN::set(self : BioseqassemblydebruijnGraphN, i : Int, v : Double) -> BioseqassemblydebruijnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnGraphN::sum(self : BioseqassemblydebruijnGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnGraphN::mean(self : BioseqassemblydebruijnGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnGraphN::scale(self : BioseqassemblydebruijnGraphN, f : Double) -> BioseqassemblydebruijnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnGraphN::add(self : BioseqassemblydebruijnGraphN, other : BioseqassemblydebruijnGraphN) -> BioseqassemblydebruijnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnGraphN::copy(self : BioseqassemblydebruijnGraphN) -> BioseqassemblydebruijnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnGraphN::fill(self : BioseqassemblydebruijnGraphN, v : Double) -> BioseqassemblydebruijnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnGraphN::min(self : BioseqassemblydebruijnGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnGraphN::max(self : BioseqassemblydebruijnGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnGraphN::to_string(self : BioseqassemblydebruijnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_node_make(size : Int) -> BioseqassemblydebruijnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnNode::len(self : BioseqassemblydebruijnNode) -> Int { self.size }

pub fn BioseqassemblydebruijnNode::get(self : BioseqassemblydebruijnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnNode::set(self : BioseqassemblydebruijnNode, i : Int, v : Double) -> BioseqassemblydebruijnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnNode::sum(self : BioseqassemblydebruijnNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnNode::mean(self : BioseqassemblydebruijnNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnNode::scale(self : BioseqassemblydebruijnNode, f : Double) -> BioseqassemblydebruijnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnNode::add(self : BioseqassemblydebruijnNode, other : BioseqassemblydebruijnNode) -> BioseqassemblydebruijnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnNode::copy(self : BioseqassemblydebruijnNode) -> BioseqassemblydebruijnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnNode::fill(self : BioseqassemblydebruijnNode, v : Double) -> BioseqassemblydebruijnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnNode::min(self : BioseqassemblydebruijnNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnNode::max(self : BioseqassemblydebruijnNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnNode::to_string(self : BioseqassemblydebruijnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_edge_make(size : Int) -> BioseqassemblydebruijnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnEdge::len(self : BioseqassemblydebruijnEdge) -> Int { self.size }

pub fn BioseqassemblydebruijnEdge::get(self : BioseqassemblydebruijnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnEdge::set(self : BioseqassemblydebruijnEdge, i : Int, v : Double) -> BioseqassemblydebruijnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnEdge::sum(self : BioseqassemblydebruijnEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnEdge::mean(self : BioseqassemblydebruijnEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnEdge::scale(self : BioseqassemblydebruijnEdge, f : Double) -> BioseqassemblydebruijnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnEdge::add(self : BioseqassemblydebruijnEdge, other : BioseqassemblydebruijnEdge) -> BioseqassemblydebruijnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnEdge::copy(self : BioseqassemblydebruijnEdge) -> BioseqassemblydebruijnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnEdge::fill(self : BioseqassemblydebruijnEdge, v : Double) -> BioseqassemblydebruijnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnEdge::min(self : BioseqassemblydebruijnEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnEdge::max(self : BioseqassemblydebruijnEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnEdge::to_string(self : BioseqassemblydebruijnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_path_make(size : Int) -> BioseqassemblydebruijnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnPath::len(self : BioseqassemblydebruijnPath) -> Int { self.size }

pub fn BioseqassemblydebruijnPath::get(self : BioseqassemblydebruijnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnPath::set(self : BioseqassemblydebruijnPath, i : Int, v : Double) -> BioseqassemblydebruijnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnPath::sum(self : BioseqassemblydebruijnPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnPath::mean(self : BioseqassemblydebruijnPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnPath::scale(self : BioseqassemblydebruijnPath, f : Double) -> BioseqassemblydebruijnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnPath::add(self : BioseqassemblydebruijnPath, other : BioseqassemblydebruijnPath) -> BioseqassemblydebruijnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnPath::copy(self : BioseqassemblydebruijnPath) -> BioseqassemblydebruijnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnPath::fill(self : BioseqassemblydebruijnPath, v : Double) -> BioseqassemblydebruijnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnPath::min(self : BioseqassemblydebruijnPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnPath::max(self : BioseqassemblydebruijnPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnPath::to_string(self : BioseqassemblydebruijnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_cluster_make(size : Int) -> BioseqassemblydebruijnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnCluster::len(self : BioseqassemblydebruijnCluster) -> Int { self.size }

pub fn BioseqassemblydebruijnCluster::get(self : BioseqassemblydebruijnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnCluster::set(self : BioseqassemblydebruijnCluster, i : Int, v : Double) -> BioseqassemblydebruijnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCluster::sum(self : BioseqassemblydebruijnCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnCluster::mean(self : BioseqassemblydebruijnCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnCluster::scale(self : BioseqassemblydebruijnCluster, f : Double) -> BioseqassemblydebruijnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCluster::add(self : BioseqassemblydebruijnCluster, other : BioseqassemblydebruijnCluster) -> BioseqassemblydebruijnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnCluster::copy(self : BioseqassemblydebruijnCluster) -> BioseqassemblydebruijnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCluster::fill(self : BioseqassemblydebruijnCluster, v : Double) -> BioseqassemblydebruijnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCluster::min(self : BioseqassemblydebruijnCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnCluster::max(self : BioseqassemblydebruijnCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnCluster::to_string(self : BioseqassemblydebruijnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_model_make(size : Int) -> BioseqassemblydebruijnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnModel::len(self : BioseqassemblydebruijnModel) -> Int { self.size }

pub fn BioseqassemblydebruijnModel::get(self : BioseqassemblydebruijnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnModel::set(self : BioseqassemblydebruijnModel, i : Int, v : Double) -> BioseqassemblydebruijnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnModel::sum(self : BioseqassemblydebruijnModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnModel::mean(self : BioseqassemblydebruijnModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnModel::scale(self : BioseqassemblydebruijnModel, f : Double) -> BioseqassemblydebruijnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnModel::add(self : BioseqassemblydebruijnModel, other : BioseqassemblydebruijnModel) -> BioseqassemblydebruijnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnModel::copy(self : BioseqassemblydebruijnModel) -> BioseqassemblydebruijnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnModel::fill(self : BioseqassemblydebruijnModel, v : Double) -> BioseqassemblydebruijnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnModel::min(self : BioseqassemblydebruijnModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnModel::max(self : BioseqassemblydebruijnModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnModel::to_string(self : BioseqassemblydebruijnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_layer_make(size : Int) -> BioseqassemblydebruijnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnLayer::len(self : BioseqassemblydebruijnLayer) -> Int { self.size }

pub fn BioseqassemblydebruijnLayer::get(self : BioseqassemblydebruijnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnLayer::set(self : BioseqassemblydebruijnLayer, i : Int, v : Double) -> BioseqassemblydebruijnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnLayer::sum(self : BioseqassemblydebruijnLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnLayer::mean(self : BioseqassemblydebruijnLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnLayer::scale(self : BioseqassemblydebruijnLayer, f : Double) -> BioseqassemblydebruijnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnLayer::add(self : BioseqassemblydebruijnLayer, other : BioseqassemblydebruijnLayer) -> BioseqassemblydebruijnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnLayer::copy(self : BioseqassemblydebruijnLayer) -> BioseqassemblydebruijnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnLayer::fill(self : BioseqassemblydebruijnLayer, v : Double) -> BioseqassemblydebruijnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnLayer::min(self : BioseqassemblydebruijnLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnLayer::max(self : BioseqassemblydebruijnLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnLayer::to_string(self : BioseqassemblydebruijnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_buffer_make(size : Int) -> BioseqassemblydebruijnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnBuffer::len(self : BioseqassemblydebruijnBuffer) -> Int { self.size }

pub fn BioseqassemblydebruijnBuffer::get(self : BioseqassemblydebruijnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnBuffer::set(self : BioseqassemblydebruijnBuffer, i : Int, v : Double) -> BioseqassemblydebruijnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnBuffer::sum(self : BioseqassemblydebruijnBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnBuffer::mean(self : BioseqassemblydebruijnBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnBuffer::scale(self : BioseqassemblydebruijnBuffer, f : Double) -> BioseqassemblydebruijnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnBuffer::add(self : BioseqassemblydebruijnBuffer, other : BioseqassemblydebruijnBuffer) -> BioseqassemblydebruijnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnBuffer::copy(self : BioseqassemblydebruijnBuffer) -> BioseqassemblydebruijnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnBuffer::fill(self : BioseqassemblydebruijnBuffer, v : Double) -> BioseqassemblydebruijnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnBuffer::min(self : BioseqassemblydebruijnBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnBuffer::max(self : BioseqassemblydebruijnBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnBuffer::to_string(self : BioseqassemblydebruijnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_cursor_make(size : Int) -> BioseqassemblydebruijnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnCursor::len(self : BioseqassemblydebruijnCursor) -> Int { self.size }

pub fn BioseqassemblydebruijnCursor::get(self : BioseqassemblydebruijnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnCursor::set(self : BioseqassemblydebruijnCursor, i : Int, v : Double) -> BioseqassemblydebruijnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCursor::sum(self : BioseqassemblydebruijnCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnCursor::mean(self : BioseqassemblydebruijnCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnCursor::scale(self : BioseqassemblydebruijnCursor, f : Double) -> BioseqassemblydebruijnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCursor::add(self : BioseqassemblydebruijnCursor, other : BioseqassemblydebruijnCursor) -> BioseqassemblydebruijnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnCursor::copy(self : BioseqassemblydebruijnCursor) -> BioseqassemblydebruijnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCursor::fill(self : BioseqassemblydebruijnCursor, v : Double) -> BioseqassemblydebruijnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnCursor::min(self : BioseqassemblydebruijnCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnCursor::max(self : BioseqassemblydebruijnCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnCursor::to_string(self : BioseqassemblydebruijnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_view_make(size : Int) -> BioseqassemblydebruijnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnView::len(self : BioseqassemblydebruijnView) -> Int { self.size }

pub fn BioseqassemblydebruijnView::get(self : BioseqassemblydebruijnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnView::set(self : BioseqassemblydebruijnView, i : Int, v : Double) -> BioseqassemblydebruijnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnView::sum(self : BioseqassemblydebruijnView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnView::mean(self : BioseqassemblydebruijnView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnView::scale(self : BioseqassemblydebruijnView, f : Double) -> BioseqassemblydebruijnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnView::add(self : BioseqassemblydebruijnView, other : BioseqassemblydebruijnView) -> BioseqassemblydebruijnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnView::copy(self : BioseqassemblydebruijnView) -> BioseqassemblydebruijnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnView::fill(self : BioseqassemblydebruijnView, v : Double) -> BioseqassemblydebruijnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnView::min(self : BioseqassemblydebruijnView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnView::max(self : BioseqassemblydebruijnView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnView::to_string(self : BioseqassemblydebruijnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_range_make(size : Int) -> BioseqassemblydebruijnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnRange::len(self : BioseqassemblydebruijnRange) -> Int { self.size }

pub fn BioseqassemblydebruijnRange::get(self : BioseqassemblydebruijnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnRange::set(self : BioseqassemblydebruijnRange, i : Int, v : Double) -> BioseqassemblydebruijnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnRange::sum(self : BioseqassemblydebruijnRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnRange::mean(self : BioseqassemblydebruijnRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnRange::scale(self : BioseqassemblydebruijnRange, f : Double) -> BioseqassemblydebruijnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnRange::add(self : BioseqassemblydebruijnRange, other : BioseqassemblydebruijnRange) -> BioseqassemblydebruijnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnRange::copy(self : BioseqassemblydebruijnRange) -> BioseqassemblydebruijnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnRange::fill(self : BioseqassemblydebruijnRange, v : Double) -> BioseqassemblydebruijnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnRange::min(self : BioseqassemblydebruijnRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnRange::max(self : BioseqassemblydebruijnRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnRange::to_string(self : BioseqassemblydebruijnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_slice_make(size : Int) -> BioseqassemblydebruijnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblydebruijnSlice::len(self : BioseqassemblydebruijnSlice) -> Int { self.size }

pub fn BioseqassemblydebruijnSlice::get(self : BioseqassemblydebruijnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblydebruijnSlice::set(self : BioseqassemblydebruijnSlice, i : Int, v : Double) -> BioseqassemblydebruijnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnSlice::sum(self : BioseqassemblydebruijnSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblydebruijnSlice::mean(self : BioseqassemblydebruijnSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblydebruijnSlice::scale(self : BioseqassemblydebruijnSlice, f : Double) -> BioseqassemblydebruijnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnSlice::add(self : BioseqassemblydebruijnSlice, other : BioseqassemblydebruijnSlice) -> BioseqassemblydebruijnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblydebruijnSlice::copy(self : BioseqassemblydebruijnSlice) -> BioseqassemblydebruijnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnSlice::fill(self : BioseqassemblydebruijnSlice, v : Double) -> BioseqassemblydebruijnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblydebruijnSlice::min(self : BioseqassemblydebruijnSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblydebruijnSlice::max(self : BioseqassemblydebruijnSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblydebruijnSlice::to_string(self : BioseqassemblydebruijnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

