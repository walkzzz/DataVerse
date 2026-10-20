///===
/// extcore/geo_dist_manhattan

pub(all) struct GeodistmanhattanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_manhattan_make_point(x : Double, y : Double) -> GeodistmanhattanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_manhattan_make_point3(x : Double, y : Double, z : Double) -> GeodistmanhattanPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistmanhattanPoint::x(self : GeodistmanhattanPoint) -> Double { self.x }

pub fn GeodistmanhattanPoint::y(self : GeodistmanhattanPoint) -> Double { self.y }

pub fn GeodistmanhattanPoint::z(self : GeodistmanhattanPoint) -> Double { self.z }

pub fn GeodistmanhattanPoint::label(self : GeodistmanhattanPoint) -> Int { self.label }

pub fn GeodistmanhattanPoint::dist(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistmanhattanPoint::add(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistmanhattanPoint::sub(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistmanhattanPoint::scale(self : GeodistmanhattanPoint, s : Double) -> GeodistmanhattanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistmanhattanPoint::dot(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistmanhattanPoint::cross(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistmanhattanPoint::norm(self : GeodistmanhattanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistmanhattanPoint::normalize(self : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistmanhattanPoint::negate(self : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistmanhattanPoint::mid(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistmanhattanPoint::lerp(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint, t : Double) -> GeodistmanhattanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistmanhattanPoint::to_string(self : GeodistmanhattanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistmanhattanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_manhattan_make_series(vals : Array[Double], name : String) -> GeodistmanhattanSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistmanhattanSeries::len(self : GeodistmanhattanSeries) -> Int { self.vals.length() }

pub fn GeodistmanhattanSeries::sum(self : GeodistmanhattanSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistmanhattanSeries::mean(self : GeodistmanhattanSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistmanhattanSeries::min(self : GeodistmanhattanSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistmanhattanSeries::max(self : GeodistmanhattanSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistmanhattanSeries::range(self : GeodistmanhattanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistmanhattanSeries::variance(self : GeodistmanhattanSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistmanhattanSeries::std(self : GeodistmanhattanSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistmanhattanSeries::median(self : GeodistmanhattanSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistmanhattanSeries::scale(self : GeodistmanhattanSeries, f : Double) -> GeodistmanhattanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::add(self : GeodistmanhattanSeries, other : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::sub(self : GeodistmanhattanSeries, other : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::normalize(self : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistmanhattanSeries::cumsum(self : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistmanhattanSeries::to_string(self : GeodistmanhattanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistmanhattanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_manhattan_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistmanhattanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_manhattan_matrix_identity(n : Int) -> GeodistmanhattanMatrix {
  let m = geo_dist_manhattan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistmanhattanMatrix::get(self : GeodistmanhattanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistmanhattanMatrix::transpose(self : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistmanhattanMatrix::add(self : GeodistmanhattanMatrix, other : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_manhattan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistmanhattanMatrix::scale(self : GeodistmanhattanMatrix, s : Double) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistmanhattanMatrix::multiply(self : GeodistmanhattanMatrix, other : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if self.cols != other.rows { return geo_dist_manhattan_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_manhattan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeodistmanhattanMatrix::trace(self : GeodistmanhattanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistmanhattanMatrix::det(self : GeodistmanhattanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistmanhattanMatrix::norm(self : GeodistmanhattanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistmanhattanMatrix::to_string(self : GeodistmanhattanMatrix) -> String {
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

pub(all) struct GeodistmanhattanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_manhattan_make_vector(comps : Array[Double]) -> GeodistmanhattanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_manhattan_vector_zero(dim : Int) -> GeodistmanhattanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistmanhattanVector::add(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistmanhattanVector::sub(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistmanhattanVector::scale(self : GeodistmanhattanVector, s : Double) -> GeodistmanhattanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistmanhattanVector::dot(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistmanhattanVector::norm(self : GeodistmanhattanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistmanhattanVector::normalize(self : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistmanhattanVector::dist(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistmanhattanVector::to_string(self : GeodistmanhattanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistmanhattanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_frame_make(size : Int) -> GeodistmanhattanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanFrame::len(self : GeodistmanhattanFrame) -> Int { self.size }

pub fn GeodistmanhattanFrame::get(self : GeodistmanhattanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanFrame::set(self : GeodistmanhattanFrame, i : Int, v : Double) -> GeodistmanhattanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanFrame::sum(self : GeodistmanhattanFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanFrame::mean(self : GeodistmanhattanFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanFrame::scale(self : GeodistmanhattanFrame, f : Double) -> GeodistmanhattanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanFrame::add(self : GeodistmanhattanFrame, other : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanFrame::copy(self : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanFrame::fill(self : GeodistmanhattanFrame, v : Double) -> GeodistmanhattanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanFrame::min(self : GeodistmanhattanFrame) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanFrame::max(self : GeodistmanhattanFrame) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanFrame::to_string(self : GeodistmanhattanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_table_make(size : Int) -> GeodistmanhattanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanTable::len(self : GeodistmanhattanTable) -> Int { self.size }

pub fn GeodistmanhattanTable::get(self : GeodistmanhattanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanTable::set(self : GeodistmanhattanTable, i : Int, v : Double) -> GeodistmanhattanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanTable::sum(self : GeodistmanhattanTable) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanTable::mean(self : GeodistmanhattanTable) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanTable::scale(self : GeodistmanhattanTable, f : Double) -> GeodistmanhattanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanTable::add(self : GeodistmanhattanTable, other : GeodistmanhattanTable) -> GeodistmanhattanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanTable::copy(self : GeodistmanhattanTable) -> GeodistmanhattanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanTable::fill(self : GeodistmanhattanTable, v : Double) -> GeodistmanhattanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanTable::min(self : GeodistmanhattanTable) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanTable::max(self : GeodistmanhattanTable) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanTable::to_string(self : GeodistmanhattanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_graphn_make(size : Int) -> GeodistmanhattanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanGraphN::len(self : GeodistmanhattanGraphN) -> Int { self.size }

pub fn GeodistmanhattanGraphN::get(self : GeodistmanhattanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanGraphN::set(self : GeodistmanhattanGraphN, i : Int, v : Double) -> GeodistmanhattanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanGraphN::sum(self : GeodistmanhattanGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanGraphN::mean(self : GeodistmanhattanGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanGraphN::scale(self : GeodistmanhattanGraphN, f : Double) -> GeodistmanhattanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanGraphN::add(self : GeodistmanhattanGraphN, other : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanGraphN::copy(self : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanGraphN::fill(self : GeodistmanhattanGraphN, v : Double) -> GeodistmanhattanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanGraphN::min(self : GeodistmanhattanGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanGraphN::max(self : GeodistmanhattanGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanGraphN::to_string(self : GeodistmanhattanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_node_make(size : Int) -> GeodistmanhattanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanNode::len(self : GeodistmanhattanNode) -> Int { self.size }

pub fn GeodistmanhattanNode::get(self : GeodistmanhattanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanNode::set(self : GeodistmanhattanNode, i : Int, v : Double) -> GeodistmanhattanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanNode::sum(self : GeodistmanhattanNode) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanNode::mean(self : GeodistmanhattanNode) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanNode::scale(self : GeodistmanhattanNode, f : Double) -> GeodistmanhattanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanNode::add(self : GeodistmanhattanNode, other : GeodistmanhattanNode) -> GeodistmanhattanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanNode::copy(self : GeodistmanhattanNode) -> GeodistmanhattanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanNode::fill(self : GeodistmanhattanNode, v : Double) -> GeodistmanhattanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanNode::min(self : GeodistmanhattanNode) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanNode::max(self : GeodistmanhattanNode) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanNode::to_string(self : GeodistmanhattanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_edge_make(size : Int) -> GeodistmanhattanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanEdge::len(self : GeodistmanhattanEdge) -> Int { self.size }

pub fn GeodistmanhattanEdge::get(self : GeodistmanhattanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanEdge::set(self : GeodistmanhattanEdge, i : Int, v : Double) -> GeodistmanhattanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanEdge::sum(self : GeodistmanhattanEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanEdge::mean(self : GeodistmanhattanEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanEdge::scale(self : GeodistmanhattanEdge, f : Double) -> GeodistmanhattanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanEdge::add(self : GeodistmanhattanEdge, other : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanEdge::copy(self : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanEdge::fill(self : GeodistmanhattanEdge, v : Double) -> GeodistmanhattanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanEdge::min(self : GeodistmanhattanEdge) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanEdge::max(self : GeodistmanhattanEdge) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanEdge::to_string(self : GeodistmanhattanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_path_make(size : Int) -> GeodistmanhattanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanPath::len(self : GeodistmanhattanPath) -> Int { self.size }

pub fn GeodistmanhattanPath::get(self : GeodistmanhattanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanPath::set(self : GeodistmanhattanPath, i : Int, v : Double) -> GeodistmanhattanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanPath::sum(self : GeodistmanhattanPath) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanPath::mean(self : GeodistmanhattanPath) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanPath::scale(self : GeodistmanhattanPath, f : Double) -> GeodistmanhattanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanPath::add(self : GeodistmanhattanPath, other : GeodistmanhattanPath) -> GeodistmanhattanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanPath::copy(self : GeodistmanhattanPath) -> GeodistmanhattanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanPath::fill(self : GeodistmanhattanPath, v : Double) -> GeodistmanhattanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanPath::min(self : GeodistmanhattanPath) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanPath::max(self : GeodistmanhattanPath) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanPath::to_string(self : GeodistmanhattanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cluster_make(size : Int) -> GeodistmanhattanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanCluster::len(self : GeodistmanhattanCluster) -> Int { self.size }

pub fn GeodistmanhattanCluster::get(self : GeodistmanhattanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanCluster::set(self : GeodistmanhattanCluster, i : Int, v : Double) -> GeodistmanhattanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCluster::sum(self : GeodistmanhattanCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanCluster::mean(self : GeodistmanhattanCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanCluster::scale(self : GeodistmanhattanCluster, f : Double) -> GeodistmanhattanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCluster::add(self : GeodistmanhattanCluster, other : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanCluster::copy(self : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCluster::fill(self : GeodistmanhattanCluster, v : Double) -> GeodistmanhattanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCluster::min(self : GeodistmanhattanCluster) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanCluster::max(self : GeodistmanhattanCluster) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanCluster::to_string(self : GeodistmanhattanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_model_make(size : Int) -> GeodistmanhattanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanModel::len(self : GeodistmanhattanModel) -> Int { self.size }

pub fn GeodistmanhattanModel::get(self : GeodistmanhattanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanModel::set(self : GeodistmanhattanModel, i : Int, v : Double) -> GeodistmanhattanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanModel::sum(self : GeodistmanhattanModel) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanModel::mean(self : GeodistmanhattanModel) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanModel::scale(self : GeodistmanhattanModel, f : Double) -> GeodistmanhattanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanModel::add(self : GeodistmanhattanModel, other : GeodistmanhattanModel) -> GeodistmanhattanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanModel::copy(self : GeodistmanhattanModel) -> GeodistmanhattanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanModel::fill(self : GeodistmanhattanModel, v : Double) -> GeodistmanhattanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanModel::min(self : GeodistmanhattanModel) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanModel::max(self : GeodistmanhattanModel) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanModel::to_string(self : GeodistmanhattanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_layer_make(size : Int) -> GeodistmanhattanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanLayer::len(self : GeodistmanhattanLayer) -> Int { self.size }

pub fn GeodistmanhattanLayer::get(self : GeodistmanhattanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanLayer::set(self : GeodistmanhattanLayer, i : Int, v : Double) -> GeodistmanhattanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanLayer::sum(self : GeodistmanhattanLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanLayer::mean(self : GeodistmanhattanLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanLayer::scale(self : GeodistmanhattanLayer, f : Double) -> GeodistmanhattanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanLayer::add(self : GeodistmanhattanLayer, other : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanLayer::copy(self : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanLayer::fill(self : GeodistmanhattanLayer, v : Double) -> GeodistmanhattanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanLayer::min(self : GeodistmanhattanLayer) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanLayer::max(self : GeodistmanhattanLayer) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanLayer::to_string(self : GeodistmanhattanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_buffer_make(size : Int) -> GeodistmanhattanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanBuffer::len(self : GeodistmanhattanBuffer) -> Int { self.size }

pub fn GeodistmanhattanBuffer::get(self : GeodistmanhattanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanBuffer::set(self : GeodistmanhattanBuffer, i : Int, v : Double) -> GeodistmanhattanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanBuffer::sum(self : GeodistmanhattanBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanBuffer::mean(self : GeodistmanhattanBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanBuffer::scale(self : GeodistmanhattanBuffer, f : Double) -> GeodistmanhattanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanBuffer::add(self : GeodistmanhattanBuffer, other : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanBuffer::copy(self : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanBuffer::fill(self : GeodistmanhattanBuffer, v : Double) -> GeodistmanhattanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanBuffer::min(self : GeodistmanhattanBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanBuffer::max(self : GeodistmanhattanBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanBuffer::to_string(self : GeodistmanhattanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cursor_make(size : Int) -> GeodistmanhattanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanCursor::len(self : GeodistmanhattanCursor) -> Int { self.size }

pub fn GeodistmanhattanCursor::get(self : GeodistmanhattanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanCursor::set(self : GeodistmanhattanCursor, i : Int, v : Double) -> GeodistmanhattanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCursor::sum(self : GeodistmanhattanCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanCursor::mean(self : GeodistmanhattanCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanCursor::scale(self : GeodistmanhattanCursor, f : Double) -> GeodistmanhattanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCursor::add(self : GeodistmanhattanCursor, other : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanCursor::copy(self : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCursor::fill(self : GeodistmanhattanCursor, v : Double) -> GeodistmanhattanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanCursor::min(self : GeodistmanhattanCursor) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanCursor::max(self : GeodistmanhattanCursor) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanCursor::to_string(self : GeodistmanhattanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_view_make(size : Int) -> GeodistmanhattanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanView::len(self : GeodistmanhattanView) -> Int { self.size }

pub fn GeodistmanhattanView::get(self : GeodistmanhattanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanView::set(self : GeodistmanhattanView, i : Int, v : Double) -> GeodistmanhattanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanView::sum(self : GeodistmanhattanView) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanView::mean(self : GeodistmanhattanView) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanView::scale(self : GeodistmanhattanView, f : Double) -> GeodistmanhattanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanView::add(self : GeodistmanhattanView, other : GeodistmanhattanView) -> GeodistmanhattanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanView::copy(self : GeodistmanhattanView) -> GeodistmanhattanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanView::fill(self : GeodistmanhattanView, v : Double) -> GeodistmanhattanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanView::min(self : GeodistmanhattanView) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanView::max(self : GeodistmanhattanView) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanView::to_string(self : GeodistmanhattanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_range_make(size : Int) -> GeodistmanhattanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanRange::len(self : GeodistmanhattanRange) -> Int { self.size }

pub fn GeodistmanhattanRange::get(self : GeodistmanhattanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanRange::set(self : GeodistmanhattanRange, i : Int, v : Double) -> GeodistmanhattanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanRange::sum(self : GeodistmanhattanRange) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanRange::mean(self : GeodistmanhattanRange) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanRange::scale(self : GeodistmanhattanRange, f : Double) -> GeodistmanhattanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanRange::add(self : GeodistmanhattanRange, other : GeodistmanhattanRange) -> GeodistmanhattanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanRange::copy(self : GeodistmanhattanRange) -> GeodistmanhattanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanRange::fill(self : GeodistmanhattanRange, v : Double) -> GeodistmanhattanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanRange::min(self : GeodistmanhattanRange) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanRange::max(self : GeodistmanhattanRange) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanRange::to_string(self : GeodistmanhattanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_slice_make(size : Int) -> GeodistmanhattanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistmanhattanSlice::len(self : GeodistmanhattanSlice) -> Int { self.size }

pub fn GeodistmanhattanSlice::get(self : GeodistmanhattanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistmanhattanSlice::set(self : GeodistmanhattanSlice, i : Int, v : Double) -> GeodistmanhattanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanSlice::sum(self : GeodistmanhattanSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistmanhattanSlice::mean(self : GeodistmanhattanSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistmanhattanSlice::scale(self : GeodistmanhattanSlice, f : Double) -> GeodistmanhattanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanSlice::add(self : GeodistmanhattanSlice, other : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistmanhattanSlice::copy(self : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanSlice::fill(self : GeodistmanhattanSlice, v : Double) -> GeodistmanhattanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistmanhattanSlice::min(self : GeodistmanhattanSlice) -> Double { @_common.min(self.data) }

pub fn GeodistmanhattanSlice::max(self : GeodistmanhattanSlice) -> Double { @_common.max(self.data) }

pub fn GeodistmanhattanSlice::to_string(self : GeodistmanhattanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

