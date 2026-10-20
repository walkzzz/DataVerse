///===
/// extcore/ds_tree_avl

pub(all) struct DstreeavlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_avl_make_point(x : Double, y : Double) -> DstreeavlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_avl_make_point3(x : Double, y : Double, z : Double) -> DstreeavlPoint {
  { x, y, z, label: 0 }
}

pub fn DstreeavlPoint::x(self : DstreeavlPoint) -> Double { self.x }

pub fn DstreeavlPoint::y(self : DstreeavlPoint) -> Double { self.y }

pub fn DstreeavlPoint::z(self : DstreeavlPoint) -> Double { self.z }

pub fn DstreeavlPoint::label(self : DstreeavlPoint) -> Int { self.label }

pub fn DstreeavlPoint::dist(self : DstreeavlPoint, other : DstreeavlPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreeavlPoint::add(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreeavlPoint::sub(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreeavlPoint::scale(self : DstreeavlPoint, s : Double) -> DstreeavlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreeavlPoint::dot(self : DstreeavlPoint, other : DstreeavlPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreeavlPoint::cross(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreeavlPoint::norm(self : DstreeavlPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreeavlPoint::normalize(self : DstreeavlPoint) -> DstreeavlPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeavlPoint::negate(self : DstreeavlPoint) -> DstreeavlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreeavlPoint::mid(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreeavlPoint::lerp(self : DstreeavlPoint, other : DstreeavlPoint, t : Double) -> DstreeavlPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreeavlPoint::to_string(self : DstreeavlPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreeavlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_avl_make_series(vals : Array[Double], name : String) -> DstreeavlSeries {
  { vals, name, meta: 0 }
}

pub fn DstreeavlSeries::len(self : DstreeavlSeries) -> Int { self.vals.length() }

pub fn DstreeavlSeries::sum(self : DstreeavlSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreeavlSeries::mean(self : DstreeavlSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreeavlSeries::min(self : DstreeavlSeries) -> Double { @_common.min(self.vals) }

pub fn DstreeavlSeries::max(self : DstreeavlSeries) -> Double { @_common.max(self.vals) }

pub fn DstreeavlSeries::range(self : DstreeavlSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreeavlSeries::variance(self : DstreeavlSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreeavlSeries::std(self : DstreeavlSeries) -> Double { @_common.std(self.vals) }

pub fn DstreeavlSeries::median(self : DstreeavlSeries) -> Double { @_common.median(self.vals) }

pub fn DstreeavlSeries::scale(self : DstreeavlSeries, f : Double) -> DstreeavlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreeavlSeries::add(self : DstreeavlSeries, other : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreeavlSeries::sub(self : DstreeavlSeries, other : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreeavlSeries::normalize(self : DstreeavlSeries) -> DstreeavlSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreeavlSeries::cumsum(self : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreeavlSeries::to_string(self : DstreeavlSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeavlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_avl_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeavlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_avl_matrix_identity(n : Int) -> DstreeavlMatrix {
  let m = ds_tree_avl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreeavlMatrix::get(self : DstreeavlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreeavlMatrix::transpose(self : DstreeavlMatrix) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreeavlMatrix::add(self : DstreeavlMatrix, other : DstreeavlMatrix) -> DstreeavlMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_avl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreeavlMatrix::scale(self : DstreeavlMatrix, s : Double) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreeavlMatrix::multiply(self : DstreeavlMatrix, other : DstreeavlMatrix) -> DstreeavlMatrix {
  if self.cols != other.rows { return ds_tree_avl_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_avl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreeavlMatrix::trace(self : DstreeavlMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreeavlMatrix::det(self : DstreeavlMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreeavlMatrix::norm(self : DstreeavlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreeavlMatrix::to_string(self : DstreeavlMatrix) -> String {
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

pub(all) struct DstreeavlVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_avl_make_vector(comps : Array[Double]) -> DstreeavlVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_avl_vector_zero(dim : Int) -> DstreeavlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreeavlVector::add(self : DstreeavlVector, other : DstreeavlVector) -> DstreeavlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeavlVector::sub(self : DstreeavlVector, other : DstreeavlVector) -> DstreeavlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeavlVector::scale(self : DstreeavlVector, s : Double) -> DstreeavlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreeavlVector::dot(self : DstreeavlVector, other : DstreeavlVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreeavlVector::norm(self : DstreeavlVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreeavlVector::normalize(self : DstreeavlVector) -> DstreeavlVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeavlVector::dist(self : DstreeavlVector, other : DstreeavlVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreeavlVector::to_string(self : DstreeavlVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeavlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_frame_make(size : Int) -> DstreeavlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlFrame::len(self : DstreeavlFrame) -> Int { self.size }

pub fn DstreeavlFrame::get(self : DstreeavlFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlFrame::set(self : DstreeavlFrame, i : Int, v : Double) -> DstreeavlFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlFrame::sum(self : DstreeavlFrame) -> Double { @_common.sum(self.data) }

pub fn DstreeavlFrame::mean(self : DstreeavlFrame) -> Double { @_common.mean(self.data) }

pub fn DstreeavlFrame::scale(self : DstreeavlFrame, f : Double) -> DstreeavlFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlFrame::add(self : DstreeavlFrame, other : DstreeavlFrame) -> DstreeavlFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlFrame::copy(self : DstreeavlFrame) -> DstreeavlFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlFrame::fill(self : DstreeavlFrame, v : Double) -> DstreeavlFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlFrame::min(self : DstreeavlFrame) -> Double { @_common.min(self.data) }

pub fn DstreeavlFrame::max(self : DstreeavlFrame) -> Double { @_common.max(self.data) }

pub fn DstreeavlFrame::to_string(self : DstreeavlFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_table_make(size : Int) -> DstreeavlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlTable::len(self : DstreeavlTable) -> Int { self.size }

pub fn DstreeavlTable::get(self : DstreeavlTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlTable::set(self : DstreeavlTable, i : Int, v : Double) -> DstreeavlTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlTable::sum(self : DstreeavlTable) -> Double { @_common.sum(self.data) }

pub fn DstreeavlTable::mean(self : DstreeavlTable) -> Double { @_common.mean(self.data) }

pub fn DstreeavlTable::scale(self : DstreeavlTable, f : Double) -> DstreeavlTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlTable::add(self : DstreeavlTable, other : DstreeavlTable) -> DstreeavlTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlTable::copy(self : DstreeavlTable) -> DstreeavlTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlTable::fill(self : DstreeavlTable, v : Double) -> DstreeavlTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlTable::min(self : DstreeavlTable) -> Double { @_common.min(self.data) }

pub fn DstreeavlTable::max(self : DstreeavlTable) -> Double { @_common.max(self.data) }

pub fn DstreeavlTable::to_string(self : DstreeavlTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_graphn_make(size : Int) -> DstreeavlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlGraphN::len(self : DstreeavlGraphN) -> Int { self.size }

pub fn DstreeavlGraphN::get(self : DstreeavlGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlGraphN::set(self : DstreeavlGraphN, i : Int, v : Double) -> DstreeavlGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlGraphN::sum(self : DstreeavlGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreeavlGraphN::mean(self : DstreeavlGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreeavlGraphN::scale(self : DstreeavlGraphN, f : Double) -> DstreeavlGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlGraphN::add(self : DstreeavlGraphN, other : DstreeavlGraphN) -> DstreeavlGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlGraphN::copy(self : DstreeavlGraphN) -> DstreeavlGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlGraphN::fill(self : DstreeavlGraphN, v : Double) -> DstreeavlGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlGraphN::min(self : DstreeavlGraphN) -> Double { @_common.min(self.data) }

pub fn DstreeavlGraphN::max(self : DstreeavlGraphN) -> Double { @_common.max(self.data) }

pub fn DstreeavlGraphN::to_string(self : DstreeavlGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_node_make(size : Int) -> DstreeavlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlNode::len(self : DstreeavlNode) -> Int { self.size }

pub fn DstreeavlNode::get(self : DstreeavlNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlNode::set(self : DstreeavlNode, i : Int, v : Double) -> DstreeavlNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlNode::sum(self : DstreeavlNode) -> Double { @_common.sum(self.data) }

pub fn DstreeavlNode::mean(self : DstreeavlNode) -> Double { @_common.mean(self.data) }

pub fn DstreeavlNode::scale(self : DstreeavlNode, f : Double) -> DstreeavlNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlNode::add(self : DstreeavlNode, other : DstreeavlNode) -> DstreeavlNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlNode::copy(self : DstreeavlNode) -> DstreeavlNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlNode::fill(self : DstreeavlNode, v : Double) -> DstreeavlNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlNode::min(self : DstreeavlNode) -> Double { @_common.min(self.data) }

pub fn DstreeavlNode::max(self : DstreeavlNode) -> Double { @_common.max(self.data) }

pub fn DstreeavlNode::to_string(self : DstreeavlNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_edge_make(size : Int) -> DstreeavlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlEdge::len(self : DstreeavlEdge) -> Int { self.size }

pub fn DstreeavlEdge::get(self : DstreeavlEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlEdge::set(self : DstreeavlEdge, i : Int, v : Double) -> DstreeavlEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlEdge::sum(self : DstreeavlEdge) -> Double { @_common.sum(self.data) }

pub fn DstreeavlEdge::mean(self : DstreeavlEdge) -> Double { @_common.mean(self.data) }

pub fn DstreeavlEdge::scale(self : DstreeavlEdge, f : Double) -> DstreeavlEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlEdge::add(self : DstreeavlEdge, other : DstreeavlEdge) -> DstreeavlEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlEdge::copy(self : DstreeavlEdge) -> DstreeavlEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlEdge::fill(self : DstreeavlEdge, v : Double) -> DstreeavlEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlEdge::min(self : DstreeavlEdge) -> Double { @_common.min(self.data) }

pub fn DstreeavlEdge::max(self : DstreeavlEdge) -> Double { @_common.max(self.data) }

pub fn DstreeavlEdge::to_string(self : DstreeavlEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_path_make(size : Int) -> DstreeavlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlPath::len(self : DstreeavlPath) -> Int { self.size }

pub fn DstreeavlPath::get(self : DstreeavlPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlPath::set(self : DstreeavlPath, i : Int, v : Double) -> DstreeavlPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlPath::sum(self : DstreeavlPath) -> Double { @_common.sum(self.data) }

pub fn DstreeavlPath::mean(self : DstreeavlPath) -> Double { @_common.mean(self.data) }

pub fn DstreeavlPath::scale(self : DstreeavlPath, f : Double) -> DstreeavlPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlPath::add(self : DstreeavlPath, other : DstreeavlPath) -> DstreeavlPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlPath::copy(self : DstreeavlPath) -> DstreeavlPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlPath::fill(self : DstreeavlPath, v : Double) -> DstreeavlPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlPath::min(self : DstreeavlPath) -> Double { @_common.min(self.data) }

pub fn DstreeavlPath::max(self : DstreeavlPath) -> Double { @_common.max(self.data) }

pub fn DstreeavlPath::to_string(self : DstreeavlPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cluster_make(size : Int) -> DstreeavlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlCluster::len(self : DstreeavlCluster) -> Int { self.size }

pub fn DstreeavlCluster::get(self : DstreeavlCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlCluster::set(self : DstreeavlCluster, i : Int, v : Double) -> DstreeavlCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlCluster::sum(self : DstreeavlCluster) -> Double { @_common.sum(self.data) }

pub fn DstreeavlCluster::mean(self : DstreeavlCluster) -> Double { @_common.mean(self.data) }

pub fn DstreeavlCluster::scale(self : DstreeavlCluster, f : Double) -> DstreeavlCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlCluster::add(self : DstreeavlCluster, other : DstreeavlCluster) -> DstreeavlCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlCluster::copy(self : DstreeavlCluster) -> DstreeavlCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlCluster::fill(self : DstreeavlCluster, v : Double) -> DstreeavlCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlCluster::min(self : DstreeavlCluster) -> Double { @_common.min(self.data) }

pub fn DstreeavlCluster::max(self : DstreeavlCluster) -> Double { @_common.max(self.data) }

pub fn DstreeavlCluster::to_string(self : DstreeavlCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_model_make(size : Int) -> DstreeavlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlModel::len(self : DstreeavlModel) -> Int { self.size }

pub fn DstreeavlModel::get(self : DstreeavlModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlModel::set(self : DstreeavlModel, i : Int, v : Double) -> DstreeavlModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlModel::sum(self : DstreeavlModel) -> Double { @_common.sum(self.data) }

pub fn DstreeavlModel::mean(self : DstreeavlModel) -> Double { @_common.mean(self.data) }

pub fn DstreeavlModel::scale(self : DstreeavlModel, f : Double) -> DstreeavlModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlModel::add(self : DstreeavlModel, other : DstreeavlModel) -> DstreeavlModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlModel::copy(self : DstreeavlModel) -> DstreeavlModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlModel::fill(self : DstreeavlModel, v : Double) -> DstreeavlModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlModel::min(self : DstreeavlModel) -> Double { @_common.min(self.data) }

pub fn DstreeavlModel::max(self : DstreeavlModel) -> Double { @_common.max(self.data) }

pub fn DstreeavlModel::to_string(self : DstreeavlModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_layer_make(size : Int) -> DstreeavlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlLayer::len(self : DstreeavlLayer) -> Int { self.size }

pub fn DstreeavlLayer::get(self : DstreeavlLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlLayer::set(self : DstreeavlLayer, i : Int, v : Double) -> DstreeavlLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlLayer::sum(self : DstreeavlLayer) -> Double { @_common.sum(self.data) }

pub fn DstreeavlLayer::mean(self : DstreeavlLayer) -> Double { @_common.mean(self.data) }

pub fn DstreeavlLayer::scale(self : DstreeavlLayer, f : Double) -> DstreeavlLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlLayer::add(self : DstreeavlLayer, other : DstreeavlLayer) -> DstreeavlLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlLayer::copy(self : DstreeavlLayer) -> DstreeavlLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlLayer::fill(self : DstreeavlLayer, v : Double) -> DstreeavlLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlLayer::min(self : DstreeavlLayer) -> Double { @_common.min(self.data) }

pub fn DstreeavlLayer::max(self : DstreeavlLayer) -> Double { @_common.max(self.data) }

pub fn DstreeavlLayer::to_string(self : DstreeavlLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_buffer_make(size : Int) -> DstreeavlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlBuffer::len(self : DstreeavlBuffer) -> Int { self.size }

pub fn DstreeavlBuffer::get(self : DstreeavlBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlBuffer::set(self : DstreeavlBuffer, i : Int, v : Double) -> DstreeavlBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlBuffer::sum(self : DstreeavlBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreeavlBuffer::mean(self : DstreeavlBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreeavlBuffer::scale(self : DstreeavlBuffer, f : Double) -> DstreeavlBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlBuffer::add(self : DstreeavlBuffer, other : DstreeavlBuffer) -> DstreeavlBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlBuffer::copy(self : DstreeavlBuffer) -> DstreeavlBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlBuffer::fill(self : DstreeavlBuffer, v : Double) -> DstreeavlBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlBuffer::min(self : DstreeavlBuffer) -> Double { @_common.min(self.data) }

pub fn DstreeavlBuffer::max(self : DstreeavlBuffer) -> Double { @_common.max(self.data) }

pub fn DstreeavlBuffer::to_string(self : DstreeavlBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cursor_make(size : Int) -> DstreeavlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlCursor::len(self : DstreeavlCursor) -> Int { self.size }

pub fn DstreeavlCursor::get(self : DstreeavlCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlCursor::set(self : DstreeavlCursor, i : Int, v : Double) -> DstreeavlCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlCursor::sum(self : DstreeavlCursor) -> Double { @_common.sum(self.data) }

pub fn DstreeavlCursor::mean(self : DstreeavlCursor) -> Double { @_common.mean(self.data) }

pub fn DstreeavlCursor::scale(self : DstreeavlCursor, f : Double) -> DstreeavlCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlCursor::add(self : DstreeavlCursor, other : DstreeavlCursor) -> DstreeavlCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlCursor::copy(self : DstreeavlCursor) -> DstreeavlCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlCursor::fill(self : DstreeavlCursor, v : Double) -> DstreeavlCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlCursor::min(self : DstreeavlCursor) -> Double { @_common.min(self.data) }

pub fn DstreeavlCursor::max(self : DstreeavlCursor) -> Double { @_common.max(self.data) }

pub fn DstreeavlCursor::to_string(self : DstreeavlCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_view_make(size : Int) -> DstreeavlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlView::len(self : DstreeavlView) -> Int { self.size }

pub fn DstreeavlView::get(self : DstreeavlView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlView::set(self : DstreeavlView, i : Int, v : Double) -> DstreeavlView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlView::sum(self : DstreeavlView) -> Double { @_common.sum(self.data) }

pub fn DstreeavlView::mean(self : DstreeavlView) -> Double { @_common.mean(self.data) }

pub fn DstreeavlView::scale(self : DstreeavlView, f : Double) -> DstreeavlView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlView::add(self : DstreeavlView, other : DstreeavlView) -> DstreeavlView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlView::copy(self : DstreeavlView) -> DstreeavlView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlView::fill(self : DstreeavlView, v : Double) -> DstreeavlView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlView::min(self : DstreeavlView) -> Double { @_common.min(self.data) }

pub fn DstreeavlView::max(self : DstreeavlView) -> Double { @_common.max(self.data) }

pub fn DstreeavlView::to_string(self : DstreeavlView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_range_make(size : Int) -> DstreeavlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlRange::len(self : DstreeavlRange) -> Int { self.size }

pub fn DstreeavlRange::get(self : DstreeavlRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlRange::set(self : DstreeavlRange, i : Int, v : Double) -> DstreeavlRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlRange::sum(self : DstreeavlRange) -> Double { @_common.sum(self.data) }

pub fn DstreeavlRange::mean(self : DstreeavlRange) -> Double { @_common.mean(self.data) }

pub fn DstreeavlRange::scale(self : DstreeavlRange, f : Double) -> DstreeavlRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlRange::add(self : DstreeavlRange, other : DstreeavlRange) -> DstreeavlRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlRange::copy(self : DstreeavlRange) -> DstreeavlRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlRange::fill(self : DstreeavlRange, v : Double) -> DstreeavlRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlRange::min(self : DstreeavlRange) -> Double { @_common.min(self.data) }

pub fn DstreeavlRange::max(self : DstreeavlRange) -> Double { @_common.max(self.data) }

pub fn DstreeavlRange::to_string(self : DstreeavlRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeavlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_slice_make(size : Int) -> DstreeavlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeavlSlice::len(self : DstreeavlSlice) -> Int { self.size }

pub fn DstreeavlSlice::get(self : DstreeavlSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeavlSlice::set(self : DstreeavlSlice, i : Int, v : Double) -> DstreeavlSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeavlSlice::sum(self : DstreeavlSlice) -> Double { @_common.sum(self.data) }

pub fn DstreeavlSlice::mean(self : DstreeavlSlice) -> Double { @_common.mean(self.data) }

pub fn DstreeavlSlice::scale(self : DstreeavlSlice, f : Double) -> DstreeavlSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeavlSlice::add(self : DstreeavlSlice, other : DstreeavlSlice) -> DstreeavlSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeavlSlice::copy(self : DstreeavlSlice) -> DstreeavlSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeavlSlice::fill(self : DstreeavlSlice, v : Double) -> DstreeavlSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeavlSlice::min(self : DstreeavlSlice) -> Double { @_common.min(self.data) }

pub fn DstreeavlSlice::max(self : DstreeavlSlice) -> Double { @_common.max(self.data) }

pub fn DstreeavlSlice::to_string(self : DstreeavlSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

